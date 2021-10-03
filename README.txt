This repository contains the code for Advent of Code 2019 (https://adventofcode.com/)

TODO:
- Can the code for day 7 be simplified? In particular can the Interpreter type be hidden again. Only expose Program for IntCode.
- Can the code that deals with continuations / coroutines for day7 be rewritten in such a way that there are several programs running concurrently in different threads?
- Can the numeric representation of addresses and values inside the IntCode computer be made more abstract so that a change from Int to Integer can be done transparently?
- Data.List.Extra minimumOn has a typo "a version of *maximum* where..."
- Use the State monad for the robot in day 11.
- Create a new stack project template?
- If day 13 can be solved without Interpreter why not day 7?
- Day 14 has failing tests for the 4th set of reactions. Why? Maybe check reddit or Google?
- Study the GHC debugger.
- Make day 17 interactive.
