# Digital Voting Platform

Abstract of the project -
```
Elections in NITK are conducted in a paper ballot system which has following issues -
1) Insecure and susceptible to corruption.
2) Voters have little to no idea about candidates, which makes elections a popularity contest.
3) Candidates have no access to voter demographics and cannot conduct any targeted persuasion campaigns.

Our proposal is to implement an integrated system for elections which has the following features -
1) Uses blockchain to implement secure voting and public vote ledgers.
2) Gives a platform to candidates to convince voters.
3) Enables voters to make informed choices.
4) Possible integration with other security measures such as integration with IRIS, unique QR on college ids.

Our solution is an web application, made with Ruby on Rails and Bootstrap. The web application will basically have three modules, details of which are mentioned below - 
1) Polling – This will be a simple user interface which will provide the voters with the choices of the candidates. The voters can choose the candidates of their choice by viewing the candidate profile.
2) Candidate’s Profile – Here the candidates can create their profile allow the voters to view it and make an informed choice about them. The candidate’s profile can be accessed by every voter.
3) Voter Demographics – This is a voter database created over the span of many elections which will allow the candidates to analyse and conduct targeted persuasion campaigns. The database will get updated after each election.
```

Setup the project using following steps:

```
git clone https://github.com/abhishekkumar2718/Digital-Hackathon.git
cd Digital-Hackathon
bundle install
rails db:create
rails db:migrate
rails db:seed
```

Details about schema, database and Model API can be found in `docs` folder.
