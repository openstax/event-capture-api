# :+1::tada: Thanks for Contributing! :tada::+1:

See [openstax/CONTRIBUTING.md](https://github.com/openstax/napkin-notes/blob/master/CONTRIBUTING.md) for more information!

# Creating a Pull Request or Issue

- add a Reviewer
- if it is linked to another Issue or Pull Request, link the Issue/PR number by editing the Issue/PR **body**
- link to the Ticket/Issue in the Issue/PR **body**

### Creating a hotfix

1. Find the commit SHA to base the hotfix on
1. create a `hotfix-*` branch
1. make a Pull request to `master` (note: it may have merge conflicts)
1. deploy the hotfix
1. merge master in (**DO NOT REBASE!** It is important to make sure the deployed commit is in master for undoability)
1. merge the Pull request

# Code to Include

- Add specs for new logic

# Reviewing a Pull Request

- Use :+1: reaction when an issue is resolved but the comment is still visible in the Pull Request page

# Merging or Closing a Pull Request

- Once everyone has reviewed, use `[Squash and Merge]` by default
- delete the branch
