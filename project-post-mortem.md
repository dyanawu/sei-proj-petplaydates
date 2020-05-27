## Project Post Mortem
Post mortems are important to understand about what happened in a project and actively think about what you learned.

Post-mortems are meant to be a blame-less space open to objective conversation about what went well and what could be improved.

Even in the examples below, where tens of millions of dollars could be lost, the best approach is to think through the series of events that led to the outcome.

Large mistakes are almost never the fault of the developer, but of the sytems and processes in place to prevent errors and problems.

[https://github.com/danluu/post-mortems](https://github.com/danluu/post-mortems)
https://blog.codinghorror.com/the-project-postmortem/



### What to Bring
Please gather as a group to answer the following questions. Take at least 30 minutes to prepare. Be honest with each other but without blaming anyone. (see the above links to see how you might approach this exercise )

#### Approach and Process

1. What in our process and approach to this project would we do differently next time?

More functionality/userflow planning to map out relational constraights might have helped us reduce the number of migrations we needed to run over the course of the project.

2. What in our process and approach to this project went well that we would repeat next time?

Frequent deploys meant we had a working project.

--

#### Code and Code Design

1. What in our code and program design in the project would we do differently next time?

Using libraries whenever available helped us reduce code written (snippet 1)

2. What in our code and program design in the project went well? Is there anything we would do the same next time?

  For each, please include code examples that each team member wrote.
  1. Code snippet up to 20 lines.

    1. Using `active_record_union` let us do something like this to combine results of two queries:
    ``` ruby
        def events_all
            self.events_attending.union(self.events).distinct
        end
    ```

  2. Code design documents or architecture drawings / diagrams.

#### WDI Unit 3 Post Mortem (individual)
1. What habits did I use during this unit that helped me?
2. What habits did I have during this unit that I can improve on?
3. How is the overall level of the course during this unit? (instruction, course materials, etc.)
