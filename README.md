# Wegeheld Email License Plate Parser

This script parses the license plates from the emails that are generated with
the Wegeheld app.

## Requirements

Python 3 with the following extra packages:

- dateutil
- pandas

R with the following extra packages:

- dplyr
- ggplot2
- magrittr
- tidyr

## Usage

Call the parsing script onto your mailboxes:

    ./email-license-plate ~/.thunderbird/PROFILE.default/Mail/Local\ Folders/Archives.sbd/????.sbd/????-??

You need to fine out what the exact path is, your email might also be in
`ImapMail` if it is not stored locally.

Then call the analysis script:

    Rscript analysis.R
