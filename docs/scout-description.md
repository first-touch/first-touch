A scout can:
[x] look for available job requests (assignments) created by clubs (directors): GET /api/v1/scout/requests -> returns all current requests available, for which the scout has not bid yet

  - Navigate to scouting -> find work
  - should list available requests from club

[x] Make a bid on a job request (assignment):
  - Navigate to scouting -> find work
  - click make a bid
  - fill in the value
  - submit the bid

[ ] View Pending Bids:
  - Navigate to scouting -> Find Work -> My Pending bids: GET /api/v1/bids?status="pending"
  - should list the requests for which the scout has bid, but it has not been accepted by the club yet

[ ] List current accepted bids: GET /api/v1/bids?status="accepted"
  - Navigate to scouting -> my assignments
  - should list requests, which the scout has bid for and have been accepted by the club

[ ] Write a report for a job request (assignment)
  - Navigate to scouting -> my assignments
  - Finds the job request in the list
  - clicks write report
  - Fills the form
  - submit -> Stores the report info and marks the job as completed
  - save -> Stores the report info. Keeps the job marked as ongoing

[ ] Write a report on club/player (no assignment)
  - Navigate to scouting -> My Reports -> Create Report
  - Fills the form
  - Save and exit -> Keeps the report unpublished
  - Save and publish -> Marks the report as published

[x] List all previously written reports:
  - Navigate to scouting -> my reports
  - should list all reports written by the scout

[ ] View a previously written report:
  - Navigate to scouting -> my reports
  - find the previously written report in the list
  - click view report
  - See all the report details
