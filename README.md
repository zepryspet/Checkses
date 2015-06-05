# Checkses
Checkpoint session analyzer
This perl script analyses the checkpoint session table in order to present the tops in an easy visual way.


USAGE:
Save the entire he firewall session table
#fw tab -t connections -u -o sessions.txt

Download the session table saved in your firewall to your computer, either upload the file to an FTP or use secure copy (you need an autorizhed user).
Download the checkses.pl perl script from this repository into the same folder you downloaded the 
Execute the script [either double clic or using the CLI ./checkses.pl or perl checkses.l] in your computer

The web browser will open showing the results in a graphic way.

Notes:
The resulting webpage requieres to load google chart API, so be sure you have internet access.
Google chart API doesn't transfer your data, all charts are rendered in your computer.
The CSS uses flex-box so be sure to use an updated web browser.
