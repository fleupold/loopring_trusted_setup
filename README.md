# Instructions

This Docker configuration to run the [Loopring Trusted Setup](https://github.com/Loopring/trusted_setup/blob/master/participants.md). In order to run this docker setup:

1. Create a paper key and a pgp key in your keybase account
2. Fill in the .env file with your variables
   - `KEYBASE_USERNAME`
   - `KEYBASE_PASSWORD` needed to "unlock" the PGP key for signing
   - `KEYBASE_PAPERKEY` your paper key you created above
   - `PREV_CID` contribution ID before yours (e.g. 0004)
   - `CURR_CID` your contribution ID (e.g. 0005)
3. Download the `sftp.credential` from the keybase chatroom and add them into the repo.
4. Build the container using docker `build -t loopring ./`
5. Run the container `docker run --env-file .env -ti loopring`