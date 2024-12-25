# Objective-C KVO: Delayed Crash Due to Unremoved Observer

This repository demonstrates a subtle bug in Objective-C related to Key-Value Observing (KVO) and memory management.  The issue arises when an observer is not properly removed before the observed object is deallocated, leading to a delayed crash that can be challenging to debug.

## The Bug
The `bug.m` file contains code that registers an observer using KVO.  However, the observer is not removed before the observed object is released, causing a crash later in the execution. The crash may not be immediate and this delay in the crash makes the debugging particularly challenging.

## The Solution
The `bugSolution.m` file provides a corrected version of the code.  It demonstrates the proper way to remove the observer using `removeObserver:forKeyPath:` before the observed object is deallocated, preventing the crash.

## How to Reproduce
1. Clone the repository.
2. Open the project in Xcode.
3. Run the application. Observe the crash in the original code, then see the fixed code in action in `bugSolution.m`.

## Key Learning
Always remember to remove KVO observers before the observed object is deallocated to prevent unexpected crashes and ensure robust memory management in your Objective-C applications.