#### Approach and Process

1. What in our process and approach to this project would we do differently next time?

_More functionality/userflow planning to map out relational constraights might have helped us reduce the number of migrations we needed to run over the course of the project_

2. What in our process and approach to this project went well that we would repeat next time?

_Frequent deploys meant we had a working project. Teammates being used to communicating remotely meant it wasn't too hard to deconflict stuff._

--

#### Code and Code Design

1. What in our code and program design in the project would we do differently next time?

2. What in our code and program design in the project went well? Is there anything we would do the same next time?

_Using libraries whenever available helped us reduce code written (snippet 1)_

  For each, please include code examples that each team member wrote.
  1. Code snippet up to 20 lines.

    ``` ruby
        # Snippet 1
        # using active_record_union let us do this instead to
        # join two queries into one ActiveRecord Collection
        def events_all
            self.events_attending.union(self.events).distinct
        end
    ```

  2. Code design documents or architecture drawings / diagrams.

#### WDI Unit 3 Post Mortem (individual)
1. What habits did I use during this unit that helped me?
2. What habits did I have during this unit that I can improve on?
3. How is the overall level of the course during this unit? (instruction, course materials, etc.)
