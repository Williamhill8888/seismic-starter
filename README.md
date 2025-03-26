# Walnut Starter Project

![walnut banner](assets/walnut_banner.png)

### Overview

A good example to get you started with using `stype`. The app is centered around
a walnut with a secret number inside.

Every time you shake the walnut, this number increments. Every time you hit the
walnut, the shell gets closer to cracking. You can only look at the number once
the shell is cracked.

### Local Development

#### Prerequisites
Make sure you have the `seismic-foundry` suite of dev tools installed. See the installation instructions [here](https://docs.seismic.systems/onboarding/publish-your-docs).


#### Installing dependencies
Make sure you have [bun](https://bun.sh/docs/installation) installed.
Install the dependencies for the project by running:

```bash
bun install
```
from the root directory.

#### Setting up the contracts

Go to the [`contracts` directory](packages/contracts/) and follow the instructions in the [`contracts` README](packages/contracts/README.md) to set up the `Walnut` contract.

#### Setting up and running the CLI

Then, go to the [`cli` directory](packages/cli/) and follow the instructions in the [`cli` README](packages/cli/README.md) to set up and run the CLI.

### Contract Updates

#Key Improvements Made:

1,Enhanced Contributor Tracking:

Now tracks which addresses contributed to each round

Records how many shakes each contributor performed

2.Event Logging:

Added events for all major actions (hit, shake, crack, reset)

Makes it easier to track walnut activity on-chain

3.New View Functions:

*getCurrentRound()* - Check current round number

*isContributor()* - Check if caller contributed this round

*getMyShakeCount()* - See how many shakes caller performed

*getShellStatus()* - Check if walnut is cracked

*getShellStrength()* - See remaining hits needed

4.Improved Access Control:

Only contributors to the current round can look

Only contributors who helped crack can reset

5.Better Modifiers:

Clear separation of cracked/intact states

More descriptive error messages
