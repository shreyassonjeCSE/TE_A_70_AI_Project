% Declare dynamic predicates to allow runtime modifications
:- dynamic is_available/1.
:- dynamic is_busy/1.

% Define personnel and their respective departments
personnel(alice, technical).
personnel(bob, technical).
personnel(clara, billing).
personnel(david, general).

% Initially, all personnel are available
is_available(alice).
is_available(bob).
is_available(clara).
is_available(david).

% Define issue categories associated with each department
department_issues(technical, ['software', 'hardware', 'networking']).
department_issues(billing, ['payment', 'invoice']).
department_issues(general, ['other']).

% Assign a personnel member to an issue based on their department and availability
assign_task_to_personnel(Task, Employee) :-
    % Check if personnel is available and belongs to the correct department for the task
    personnel(Employee, Department),
    department_issues(Department, Tasks),
    member(Task, Tasks),
    is_available(Employee),
    
    % Update the availability status of the personnel member
    retract(is_available(Employee)),
    assertz(is_busy(Employee)).

% Release a personnel member from being busy and make them available again
make_personnel_available(Employee) :-
    % Ensure the personnel is currently busy before making them available
    is_busy(Employee),
    retract(is_busy(Employee)),
    assertz(is_available(Employee)).
