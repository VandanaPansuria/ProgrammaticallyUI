//
//  TableViewSelectionController.swift
//  ScanQR
//
//  Created by MacV on 05/01/22.
//

import UIKit

public class TableViewSelectionController {
    
    public enum ScrollingSpeed {
        case fast
        case moderate
        case slow
        case custom(rowsPerSecond: Float)
    }
    
    public weak var delegate: TableViewSelectionControllerDelegate?
    public var enabled: Bool {
        didSet {
            if enabled {
                layoutTouchView()
                printDebugMessage("ENABLED")
            } else {
                invalidate()
                printDebugMessage("DISABLED")
            }
        }
    }
    public var touchViewWidth: CGFloat {
        didSet {
            forceLayoutTouchView = true
            layoutTouchView()
        }
    }
    public var touchViewRespectsSafeArea: Bool {
        didSet {
            forceLayoutTouchView = true
            layoutTouchView()
        }
    }
    public var topScrollingAnchor: CGFloat
    public var bottomScrollingAnchor: CGFloat
    public var scrollingSpeed: ScrollingSpeed
    public var shouldUseEstimatedRowHeightWhenScrolling: Bool
    public var isInDebugMode: Bool {
        return debugColor != nil
    }
    
    // MARK: - Private Properties
    
    private weak var tableView: UITableView!
    private var touchView: UIView!
    private var forceLayoutTouchView: Bool = true
    private var customConstraintClosure: ((_ touchView: UIView) -> [NSLayoutConstraint]?)? {
        didSet {
            forceLayoutTouchView = true
            layoutTouchView()
        }
    }
    
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    private var debugColor: UIColor?
    
    private var currentPanDetails = PanDetails()
    private var currentScrollDetails = ScrollDetails()
    private var scrollTimer: Timer?
    private var debugLogDateFormatter: DateFormatter
    
    // MARK: - Initialization
    
    public init(tableView: UITableView) {
        
        self.tableView = tableView
        
        enabled = false
        scrollingSpeed = .moderate
        touchViewWidth = 60.0
        topScrollingAnchor = 40.0
        bottomScrollingAnchor = -40.0
        shouldUseEstimatedRowHeightWhenScrolling = true
        touchViewRespectsSafeArea = false
        
        debugLogDateFormatter = DateFormatter()
        debugLogDateFormatter.timeZone = TimeZone.current
        debugLogDateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss.SSSS"
    }
    public convenience init(tableView: UITableView, scrollingSpeed: ScrollingSpeed) {
        
        self.init(tableView: tableView)
        self.scrollingSpeed = scrollingSpeed
    }
    public func setCustomConstraints(_ closure: @escaping (_ touchView: UIView) -> [NSLayoutConstraint]?) {
        customConstraintClosure = closure
    }
    public func clearCustomConstraints() {
        customConstraintClosure = nil
    }
    public func setDebugMode(on: Bool, color: UIColor = .green) {
        
        if on {
            debugColor = color
            touchView?.backgroundColor = color
            printDebugMessage("DEBUG MODE ON")
        } else {
            printDebugMessage("DEBUG MODE OFF")
            debugColor = nil
            touchView?.backgroundColor = .clear
        }
    }
    
    // MARK: - Memory Management
    deinit {
        invalidate()
    }
    
    public func invalidate() {
        
        if let gesture = tapGestureRecognizer, let gestures = touchView?.gestureRecognizers, gestures.contains(gesture) {
            touchView.removeGestureRecognizer(gesture)
        }
        if let gesture = panGestureRecognizer, let gestures = touchView?.gestureRecognizers, gestures.contains(gesture) {
            touchView.removeGestureRecognizer(gesture)
        }
        tapGestureRecognizer = nil
        panGestureRecognizer = nil
        
        touchView?.removeFromSuperview()
        tableView.superview?.layoutIfNeeded()
        
        scrollTimer?.invalidate()
        scrollTimer = nil
        
        printDebugMessage("INVALIDATED")
    }
}

// MARK: - Delegate Protocol

public protocol TableViewSelectionControllerDelegate: class {
    
    func tableViewSelectionPanningDidBegin()
    func tableViewSelectionPanningDidEnd()
}

// MARK: - Internal Code
private extension TableViewSelectionController {
    
    private var scrollAnimationDuration: Float {
        
        switch scrollingSpeed {
        case .fast:
            return 1 / 40
        case .moderate:
            return 1 / 20
        case .slow:
            return 1 / 10
        case .custom(let rowsPerSecond):
            return Float(1 / rowsPerSecond)
        }
    }
    
    private enum PanDirection {
        case none
        case down
        case up
    }
    
    private enum PanMode {
        case selecting
        case deselecting
    }
    
    private struct PanDetails {
        
        var direction: PanDirection = .none
        var mode: PanMode = .selecting
        var position: CGPoint = .zero
        var indexPath: IndexPath?
        
        mutating func switchSelectionMode() {
            mode = mode == .selecting ? .deselecting : .selecting
        }
        
        var isSelecting: Bool {
            return mode == .selecting
        }
        
        var description: String {
            
            var str = ""
            
            switch direction {
            case .down:
                str += "   direction: down\n"
            case .up:
                str += "   direction: up\n"
            case .none:
                str += "   direction: none\n"
            }
            
            switch mode {
            case .selecting:
                str += "   mode: selecting\n"
            case .deselecting:
                str += "   mode: deselecting\n"
            }
            
            str += "   position: \(position)"
            
            if let indexPath = indexPath {
                str += "\n   indexPath: \(indexPath)"
            }
            
            return str
        }
    }
    
    private struct ScrollDetails {
        
        var isScrolling: Bool = false
        var startTime: Date?
        var startOffset: CGPoint?
        var destinationOffset: CGPoint?
        var duration: TimeInterval?
        var startingIndexPath: IndexPath?
        var rowsChanged: Int = 0
        
        var description: String {
            
            var str = ""
            
            str += "    isScrolling: \(isScrolling)\n"
            
            if let startTime = startTime {
                str += "    startTime: \(startTime)\n"
            }
            
            if let startOffset = startOffset {
                str += "    startOffset: \(startOffset)\n"
            }
            
            if let startingIndexPath = startingIndexPath {
                str += "    startingIndexPath: \(startingIndexPath)\n"
            }
            
            if let destinationOffset = destinationOffset {
                str += "    destinationOffset: \(destinationOffset)\n"
            }
            
            if let duration = duration {
                str += "    duration: \(duration)\n"
            }
            
            str += "    rowsChanged: \(rowsChanged)"
            
            return str
        }
    }
    
    // MARK: - Layout
    
    private func layoutTouchView() {
        
        if tableView.superview == nil || (touchView != nil && touchView.superview != nil && !forceLayoutTouchView) {
            return
        }
        
        forceLayoutTouchView = false
        touchView?.removeFromSuperview()
        touchView = UIView()
        touchView.translatesAutoresizingMaskIntoConstraints = false
        touchView.backgroundColor = debugColor ?? .clear
        touchView.alpha = 0.5
        tableView.superview!.addSubview(touchView)
        
        if let closure = customConstraintClosure, let customConstraints = closure(touchView), customConstraints.count > 0 {
            NSLayoutConstraint.activate(customConstraints)
            printDebugMessage("LAYED OUT WITH CUSTOM CONSTRAINTS:", object: customConstraints)
        } else {
            let constraints: [NSLayoutConstraint]
            if touchViewRespectsSafeArea {
                constraints = [
                    touchView.leadingAnchor.constraint(equalTo: tableView.superview!.layoutMarginsGuide.leadingAnchor, constant: -10.0),
                    touchView.trailingAnchor.constraint(equalTo: tableView.superview!.layoutMarginsGuide.leadingAnchor, constant: touchViewWidth),
                    touchView.bottomAnchor.constraint(equalTo: tableView.superview!.layoutMarginsGuide.bottomAnchor, constant: 10.0),
                    touchView.topAnchor.constraint(equalTo: tableView.superview!.layoutMarginsGuide.topAnchor)
                ]
            } else {
                constraints = [
                    touchView.leadingAnchor.constraint(equalTo: tableView.superview!.leadingAnchor, constant: -10.0),
                    touchView.trailingAnchor.constraint(equalTo: tableView.superview!.layoutMarginsGuide.leadingAnchor, constant: touchViewWidth),
                    touchView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor, constant: 10.0),
                    touchView.topAnchor.constraint(equalTo: tableView.superview!.topAnchor)
                ]
            }
            NSLayoutConstraint.activate(constraints)
            printDebugMessage("LAYED OUT WITH DEFAULT CONSTRAINTS:", object: constraints)
        }
        tableView.superview!.bringSubview(toFront: touchView)
        tableView.superview!.layoutIfNeeded()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        touchView.addGestureRecognizer(tapGestureRecognizer)
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        panGestureRecognizer.maximumNumberOfTouches = 1
        panGestureRecognizer.minimumNumberOfTouches = 1
        touchView.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Tapping
    
    @objc private func tap() {
        if let indexPath = tableView.indexPathForRow(at: tapGestureRecognizer.location(in: tableView)) {
            
            if let selectedIndexPaths = tableView.indexPathsForSelectedRows, selectedIndexPaths.contains(indexPath) {
                changeRowSelection(at: indexPath, select: false)
            } else {
                changeRowSelection(at: indexPath, select: true)
            }
        }
    }
    
    // MARK: - Panning & Scrolling
    
    @objc private func pan() {
        if panGestureRecognizer.state == .began {
            delegate?.tableViewSelectionPanningDidBegin()
            currentPanDetails = PanDetails()
            currentPanDetails.position = panGestureRecognizer.location(in: tableView.superview!)
            if let indexPath = getIndexPathAtSuperviewPosition(currentPanDetails.position) {
                currentPanDetails.indexPath = indexPath
                if let selectedIndexPaths = tableView.indexPathsForSelectedRows, selectedIndexPaths.contains(indexPath) {
                    currentPanDetails.mode = .deselecting
                    changeRowSelection(at: indexPath, select: false)
                } else {
                    currentPanDetails.mode = .selecting
                    changeRowSelection(at: indexPath, select: true)
                }
            }
            printDebugMessage("BEGAN PANNING:", object: currentPanDetails.description)
        } else if panGestureRecognizer.state == .changed {
            let newPanningPosition = panGestureRecognizer.location(in: tableView.superview!)
            if fabs(newPanningPosition.y - currentPanDetails.position.y) < 5.0 {
                return
            }
            let isPanningDown = newPanningPosition.y > currentPanDetails.position.y
            let directionChanged = (isPanningDown && currentPanDetails.direction == .up) || (!isPanningDown && currentPanDetails.direction == .down)
            if currentScrollDetails.isScrolling && !directionChanged {
                printDebugMessage("PANNING POSITION CHANGED BUT IGNORED BECAUSE IT WAS LESS THAN 5.0 PIXELS")
                return
            }
            currentPanDetails.position = newPanningPosition
            currentPanDetails.direction = isPanningDown ? .down : .up
            guard let indexPath = getIndexPathAtSuperviewPosition(currentPanDetails.position) else {
                printDebugMessage("COULD NOT FIND INDEX PATH WHILE PANNING:", object: currentPanDetails.description)
                return
            }
            
            if directionChanged {
                if currentScrollDetails.isScrolling {
                    currentScrollDetails.isScrolling = false
                    scrollTimer?.invalidate()
                    scrollTimer = nil
                }
                currentPanDetails.switchSelectionMode()
                changeRowSelection(at: indexPath, select: currentPanDetails.isSelecting)
                currentPanDetails.indexPath = indexPath
                
                printDebugMessage("DIRECTION CHANGED WHILE PANNING:", object: currentPanDetails.description)
                
            } else if !isAtEdgeOfTableView() {
                if let starting = currentPanDetails.indexPath {
                    let rowsMissed: Int
                    if currentPanDetails.direction == .down {
                        rowsMissed = getNumberOfRowsBetween(firstIndexPath: starting, secondIndexPath: indexPath)
                    } else {
                        rowsMissed = getNumberOfRowsBetween(firstIndexPath: indexPath, secondIndexPath: starting)
                    }
                    if rowsMissed > 1 {
                        changeRowSelection(from: indexPath,
                                           numberOfRows: rowsMissed,
                                           select: currentPanDetails.isSelecting,
                                           direction: currentPanDetails.direction)
                    } else {
                        changeRowSelection(at: indexPath, select: currentPanDetails.isSelecting)
                    }
                }
                currentPanDetails.indexPath = indexPath
                
                printDebugMessage("CONTINUED PANNING IN SAME DIRECTION", object: currentPanDetails.description)
                
            } else {
                currentScrollDetails = ScrollDetails()
                currentScrollDetails.isScrolling = true
                currentScrollDetails.startingIndexPath = indexPath
                
                currentScrollDetails.startOffset = tableView.contentOffset
                
                let destinationIndexPath: IndexPath?
                
                if currentPanDetails.direction == .down {
                    currentScrollDetails.destinationOffset = CGPoint(x: tableView.contentOffset.x, y: tableView.contentSize.height - tableView.bounds.height)
                    destinationIndexPath = getLastIndexPath()
                } else {
                    currentScrollDetails.destinationOffset = CGPoint(x: tableView.contentOffset.x, y: -tableView.frame.origin.y)
                    destinationIndexPath = getFirstIndexPath()
                }
                
                if let destination = destinationIndexPath {
                    let rowsToScroll: Float
                    if currentPanDetails.direction == .down {
                        rowsToScroll = Float(getNumberOfRowsBetween(firstIndexPath: indexPath, secondIndexPath: destination))
                    } else {
                        rowsToScroll = Float(getNumberOfRowsBetween(firstIndexPath: destination, secondIndexPath: indexPath))
                    }
                    currentScrollDetails.startTime = Date()
                    currentScrollDetails.duration = TimeInterval(rowsToScroll * scrollAnimationDuration)
                    scrollTimer = Timer.scheduledTimer(timeInterval: 0.001,
                                                       target: self,
                                                       selector: #selector(scrollAndSelect),
                                                       userInfo: nil,
                                                       repeats: true)
                    
                    printDebugMessage("BEGAN SCROLLING:", object: currentPanDetails.description)
                    
                } else {
                    printDebugMessage("COULD NOT BEGIN SCROLLING BECAUSE destinationIndexPath COULD NOT BE COMPUTED", object: currentPanDetails.description)
                }
            }
            
        } else if panGestureRecognizer.state == .ended || panGestureRecognizer.state == .cancelled {
            currentScrollDetails.isScrolling = false
            scrollTimer?.invalidate()
            scrollTimer = nil
            delegate?.tableViewSelectionPanningDidEnd()
            
            printDebugMessage("ENDED PANNING:", object: currentPanDetails.description)
        }
    }
    
    @objc private func scrollAndSelect() {
        
        if !currentScrollDetails.isScrolling {
            scrollTimer?.invalidate()
            scrollTimer = nil
            printDebugMessage("SCROLLING INTERRUPTED:", object: "\(currentPanDetails.description)\n\(currentScrollDetails.description)\ncurrentContnetOffset: \(tableView.contentOffset)")
            return
        }
        let timeRunning: TimeInterval = -currentScrollDetails.startTime!.timeIntervalSinceNow
        let destinationOffset: CGPoint
        if shouldUseEstimatedRowHeightWhenScrolling {
            destinationOffset = currentScrollDetails.destinationOffset!
        } else if currentPanDetails.direction == .down {
            destinationOffset = CGPoint(x: tableView.contentOffset.x, y: tableView.contentSize.height - tableView.bounds.height)
        } else {
            destinationOffset = CGPoint(x: tableView.contentOffset.x, y: -tableView.safeAreaInsets.top)
        }
        let rowsPassed = Int(timeRunning / Double(scrollAnimationDuration)) + 1
        if rowsPassed >= currentScrollDetails.rowsChanged {
            if let selectionFromIndexPath = getIndexPathOffsetFrom(indexPath: currentPanDetails.indexPath!,
                                                                   by: currentScrollDetails.rowsChanged * (currentPanDetails.direction == .down ? 1 : -1)) {
                
                changeRowSelection(from: selectionFromIndexPath,
                                   numberOfRows: rowsPassed - currentScrollDetails.rowsChanged,
                                   select: currentPanDetails.isSelecting,
                                   direction: currentPanDetails.direction)
                
                currentScrollDetails.rowsChanged = rowsPassed
            }
        }
        
        if timeRunning >= currentScrollDetails.duration! {
            changeRowSelection(at: currentPanDetails.direction == .down ? getLastIndexPath()! : getFirstIndexPath()!,
                               select: currentPanDetails.isSelecting)
            tableView.setContentOffset(destinationOffset, animated: false)
            scrollTimer?.invalidate()
            scrollTimer = nil
            
            printDebugMessage("SCROLLING REACHED END OF TABLE VIEW:", object: "\(currentPanDetails.description)\n\(currentScrollDetails.description)\ncurrentContnetOffset: \(tableView.contentOffset)")
            
        } else {
            let distanceTraveled: CGFloat
            let newOffset: CGPoint
            if currentPanDetails.direction == .down {
                distanceTraveled = (destinationOffset.y - currentScrollDetails.startOffset!.y) * CGFloat(timeRunning / currentScrollDetails.duration!)
                newOffset = CGPoint(x: tableView.contentOffset.x, y: currentScrollDetails.startOffset!.y + distanceTraveled)
            } else {
                distanceTraveled = fabs(currentScrollDetails.startOffset!.y - currentScrollDetails.destinationOffset!.y) * CGFloat(timeRunning / currentScrollDetails.duration!)
                newOffset = CGPoint(x: tableView.contentOffset.x, y: currentScrollDetails.startOffset!.y - distanceTraveled)
            }
            tableView.setContentOffset(newOffset, animated: false)
            printDebugMessage("SCROLLING CONTINUED:", object: "\(currentPanDetails.description)\n\(currentScrollDetails.description)\ncurrentContnetOffset: \(tableView.contentOffset)")
        }
        
    }
    
    // MARK: - Helper Functions
    private func getIndexPathAtSuperviewPosition(_ superviewPosition: CGPoint) -> IndexPath? {
        return tableView.indexPathForRow(at: tableView.superview!.convert(superviewPosition, to: tableView))
    }
    private func getNumberOfRowsBetween(firstIndexPath first: IndexPath, secondIndexPath second: IndexPath) -> Int {
        
        var diff = 0
        var curIndexPath = first
        while curIndexPath != second {
            diff += 1
            if tableView.numberOfRows(inSection: curIndexPath.section) > curIndexPath.row + 1 {
                curIndexPath = IndexPath(row: curIndexPath.row + 1, section: curIndexPath.section)
            } else if tableView.numberOfSections > curIndexPath.section + 1 {
                curIndexPath = IndexPath(row: 0, section: curIndexPath.section + 1)
            } else {
                return -1
            }
        }
        
        return diff
    }
    private func getFirstIndexPath() -> IndexPath? {
        var section = 0
        let totalSections = tableView.numberOfSections
        while section < totalSections {
            if tableView.numberOfRows(inSection: section) > 0 {
                return IndexPath(row: 0, section: section)
            }
            section += 1
        }
        return nil
    }
    private func getLastIndexPath() -> IndexPath? {
        var section = tableView.numberOfSections - 1
        while section >= 0 {
            let rows = tableView.numberOfRows(inSection: section)
            if rows > 0 {
                return IndexPath(row: rows - 1, section: section)
            } else {
                section -= 1
            }
        }
        
        return nil
    }
    private func getIndexPathOffsetFrom(indexPath: IndexPath, by offset: Int) -> IndexPath? {
        
        if offset == 0 {
            return indexPath
        }
        
        var rowsCounted = 0
        var section = indexPath.section
        var row = indexPath.row
        
        let totalSections = tableView.numberOfSections
        
        while section < totalSections && section >= 0 {
            
            let rowsInSection = tableView.numberOfRows(inSection: section)
            while row < rowsInSection && row >= 0 {
                if rowsCounted == abs(offset) {
                    return IndexPath(row: row, section: section)
                }
                rowsCounted += 1
                row += offset > 0 ? 1 : -1
            }
            
            row = offset > 0 ? 0 : rowsInSection - 1
            section += offset > 0 ? 1 : -1
        }
        
        return nil
        
    }
    private func changeRowSelection(from fromIndexPath: IndexPath, numberOfRows: Int, select: Bool, direction: PanDirection) {
        
        var indexPath = fromIndexPath
        var count = 0
        while count < numberOfRows {
            changeRowSelection(at: indexPath, select: select)
            if let nextIndexPath = getIndexPathOffsetFrom(indexPath: indexPath, by: direction == .down ? 1 : -1) {
                indexPath = nextIndexPath
            } else {
                return
            }
            count += 1
        }
    }
    private func changeRowSelection(at indexPath: IndexPath, select: Bool) {
        if select && (tableView.indexPathsForSelectedRows == nil || !tableView.indexPathsForSelectedRows!.contains(indexPath)) {
            printDebugMessage("ROW SELECTED AT \(indexPath)")
            tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
        } else if !select && (tableView.indexPathsForSelectedRows != nil && tableView.indexPathsForSelectedRows!.contains(indexPath)) {
            printDebugMessage("ROW DESELECTED AT \(indexPath)")
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.delegate?.tableView?(tableView, didDeselectRowAt: indexPath)
        } else {
            printDebugMessage("TRIED TO \(select ? "SELECT" : "DESELECT") ROW AT \(indexPath) BUT IT ALREADY WAS")
        }
    }
    private func isAtEdgeOfTableView() -> Bool {
        let superviewRect = UIEdgeInsetsInsetRect(tableView.superview!.frame, tableView.safeAreaInsets)
        if currentPanDetails.direction == .down {
            return currentPanDetails.position.y > (superviewRect.origin.y + superviewRect.height) + bottomScrollingAnchor
        } else {
            return currentPanDetails.position.y < superviewRect.origin.y + topScrollingAnchor
        }
    }
    private func printDebugMessage(_ message: String, object: Any? = nil) {
        
        if isInDebugMode {
            var msg = "TableViewScrollAndSelect DEBUG LOG <\(debugLogDateFormatter.string(from: Date()))> -> \(message)"
            if let obj = object {
                msg += "\n{\n\(obj)\n}"
            }
            print(msg)
        }
    }
}
