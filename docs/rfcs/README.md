# Docs Working Group Requests For Comments

The Cloud Foundry Docs Working Group uses this directory to make, discuss, and record decisions that are relevant only to the Docs Working Group and its repositories, such as content styling, organization and navigation, and publishing tooling. Decisions that affect the wider community or other working groups belong in the community [RFC directory](https://github.com/cloudfoundry/community/tree/main/toc/rfc).

This directory follows the community [RFC process](https://github.com/cloudfoundry/community/blob/216687a40c1da250a97fee323a6008dce0b2355f/toc/rfc/README.md), with the differences described below. Where this README is silent, the community process applies.

## Process

### Draft Creation

1. Create a new branch on this repository or on a fork of it.
1. Copy the community [`rfc-template.md`](https://github.com/cloudfoundry/community/blob/main/toc/rfc/rfc-template.md) to `rfc-draft-<my-proposal-title>.md` in this directory, where `<my-proposal-title>` is a short identifier for the RFC, and edit the draft RFC document.
1. If your RFC includes images, include them in a separate directory named `rfc-draft-<my-proposal-title>` and link to them from the RFC document.

### Public Discussion Period

1. Make a Pull Request (PR) for your branch.
1. Update the metadata section in your RFC draft with a link to its PR.
1. Mention the Docs Working Group leads, and any other relevant working groups, in your PR to raise awareness of the proposed RFC.
1. Community members discuss your proposal using both inline comments on your RFC document and the general PR comments section.
1. As changes are requested and agreed upon in comments, make corresponding changes in your RFC draft and push them as new commits.
1. Stay active in the discussion and encourage and remind other relevant people to participate. If you start an RFC, it is up to you to engage people to guide it through the process.

### Final Comment Period

1. Once enough of the discussions conclude, propose a motion for a Final Comment Period (FCP), including the desired outcome ("accepted" or "rejected").
1. For the FCP to start, a majority of the Docs Working Group leads must approve the FCP motion. The FCP lasts for 7 days.
1. Once the FCP starts, approvals are given using the GitHub review system. The PR can be merged or closed early if there is consensus among the Docs Working Group leads.
1. If substantial new issues are raised during the FCP, the RFC goes back into the public discussion phase.
1. If the RFC is rejected, the author or a Docs Working Group lead closes the PR with a suitable comment.

### Number Assignment

Each accepted RFC is assigned the next number in this directory's own sequence, replacing the `draft` segment in the names of its document and its optional image directory (for example, `rfc-0001-<my-proposal-title>.md`). This sequence is separate from the community-wide RFC sequence. The person merging an accepted RFC assigns its number in the same PR or immediately after it.

## Managing Standards and Processes

An RFC that defines a standard or a process should not be substantially altered after it is accepted, although it is fine to correct typos and other mistakes in a new PR. To change a standard or process, a new RFC must supersede the original:

1. Create a new RFC PR as above, noting in the summary which RFC it supersedes.
1. In the same branch, change the status of the original RFC to "Superseded", link to the new RFC, and use `git mv` to move it into an `archived` directory.
1. When the new RFC is accepted and the PR is merged, the original RFC is no longer active.

The community README [defines](https://github.com/cloudfoundry/community/blob/216687a40c1da250a97fee323a6008dce0b2355f/toc/rfc/README.md#definitions) standards and processes.

## Managing Action Plans

For an RFC where the outcome is an agreed action plan, you may update the RFC with meaningful status updates in new PRs. Once the plan is either complete or no longer relevant, move it to the `archived` directory in a new PR.
