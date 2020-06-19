# Meeting 18.06.2020

[TOC]

## Agenda

1. (30 mins max) "tour de la table"/ round of introductions
2. Recap of previous exchanges on the preliminary work done by PV
3. Agree on how to proceed next for manual verification of French definitions from Eulexis that could not be found automatically in Perseus' LSJ data
4. Agree on a platform to work, discuss and exchange data
5. agree on email to G. Greco (see draft below)

## Minutes

**Participants**: Philippe Verkerk (PV), David Bouvier (DB), Bridget Almas (BA), Aurélien Berra (AB), Matteo Romanello (MR), Bastien Kindt (BK), Helma Dik (HD)

**Apologies**: Michèle Brunet (MB) 

### Notes from discussion

- We exchanged quite a bit on LSJ short definitions: various versions derived from Perseus' XML version and used ni other projects (Diogenes, Logeion, Eulexis)
- Use of Eulexis Desktop (rather than a Web solution) to verify French definitions from Baillot aligned with lemmata from LSJ/Perseus
- once we have an online presence (GH repository) we can advertise our activities on French speaking mailing lists to find volunteers 
- how to prioritise the list of lemmata to verify: project-based? on basis of corpus frequency? 

### Decisions

- we agreed to work in GitHub (GH), in a public repository
- we agreed not to develop a Web-based tool to carry out 
- we agreed on the following rough workflow for verification of definitions:
  - identification of lemmata needing manual verification
  - these lemmata will be **priotised based on their corpus frequency** in Logeion
  - the lemmata are then **randomised** and chunked up into batches
  - each batch is assigned to a hellenist for verification (or pair of hellenists with varying levels of "authority") 
  - the verification is done via a dedicated function implemented by PV in the desktop version of Eulexis
  - batches of verified (or skipped) definitions are checked into GH 

### Action points

- [ ] HD shares with PV her version of Perseus' LSJ short definitions
- [ ] MR to set up the public GH repository + basic description in README
- [ ] PV to identify/prioritise lemmata needing manual verification + divide into batches
- [ ] MR/PV (+ others?) to try out and document in more detail the verification workflow