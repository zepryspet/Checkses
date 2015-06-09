#!/usr/local/perl -w
# Change above line to point to your perl binary


use warnings;
use strict;
use 5.012;

### Create the HTML file, the CSS style and initialize the google chart api
GoooglechartInit();
### Fill the google chart javascript with the relevant top data.
Toprotocol();
Topservices();
Toppolicies();
Topsources();
Topdestinations();
### Create the HTML body, where the charts are located.
GooglechartEnd();
###opening the resulting HTML web page
 `Topgraphs.html`;

sub GoooglechartInit{
open REPORT, ">Topgraphs.html" or die $!;
say REPORT	'<!DOCTYPE html>';
say REPORT	'<html> ';
say REPORT	'  <head> ';

##### Writing the CSS using Flexbox
say REPORT	'    <style>';
say REPORT	' 		.Protocols, .Services, .Policies, .Sources, .Destinations{';
say REPORT	' 			display: flex;';
say REPORT	' 			align-items: center;';
say REPORT	' 			justify-content: space-around;';
say REPORT	' 		}';
say REPORT	'    </style>';
say REPORT	'    <!--Load the AJAX API--> ';
say REPORT	'    <script type="text/javascript" src="https://www.google.com/jsapi"></script> ';
say REPORT	'    <script type="text/javascript"> ';

say REPORT	'      // Load the Visualization API, the piechart and table package.';
say REPORT	"      google.load(\'visualization\', '1.0', {\'packages\':[\'corechart\' , \'table\']});";

say REPORT	'      // Set a callback to run when the Google Visualization API is loaded.';
say REPORT	'      google.setOnLoadCallback(drawChart);';
say REPORT	'      // Callback that creates and populates a data table,';
say REPORT	'      // instantiates the charts and tables, passes in the data and';
say REPORT	'      // draws it.';
say REPORT	'      function drawChart() {';
say REPORT	'         // Create the data tables.';
close REPORT or die $!;
}

sub GooglechartEnd{
open REPORT, ">>Topgraphs.html" or die $!;
########## Modifying the charts options
say REPORT	'         // Set charts options ';
say REPORT	"         var options = {titleTextStyle: {color: \'#0077B5\'},";
say REPORT	'                      width:800,';
say REPORT	'                      height:600,';
say REPORT	' 					   pieHole:0.4,';
say REPORT	" 					   legend: {textStyle: {color: \'#0077B5\'}}};\n\n";


########## Drawing the charts and tables

####### Top protocols
say REPORT	'         // Instantiate and draw our Top protocols chart & table, passing in some options.';
say REPORT	"         var chartProtocol = new google.visualization.PieChart(document.getElementById(\'TopProtocol\'));";
say REPORT	'         chartProtocol.draw(dataProtocol, options);';
say REPORT	"         var TableProtocol = new google.visualization.Table(document.getElementById(\'TableProtocol\'));";
say REPORT	"         TableProtocol.draw(dataProtocol, {showRowNumber: true});";

######## Top services
say REPORT	'         // Instantiate and draw our Top servies chart & table, passing in some options.';
say REPORT	"         var chartService = new google.visualization.PieChart(document.getElementById(\'TopService\'));";
say REPORT	'         chartService.draw(dataService, options);';
say REPORT	"         var TableService = new google.visualization.Table(document.getElementById(\'TableService\'));";
say REPORT	"         TableService.draw(dataService, {showRowNumber: true});";

######## Top policies
say REPORT	'         // Instantiate and draw our Top services chart & table, passing in some options.';
say REPORT	"         var chartPolicy = new google.visualization.PieChart(document.getElementById(\'TopPolicy\'));";
say REPORT	'         chartPolicy.draw(dataPolicy, options);';
say REPORT	"         var TablePolicy = new google.visualization.Table(document.getElementById(\'TablePolicy\'));";
say REPORT	"         TablePolicy.draw(dataPolicy, {showRowNumber: true});";

######## Top Sources
say REPORT	'         // Instantiate and draw our Top Sources IPS chart & table, passing in some options.';
say REPORT	"         var chartSource = new google.visualization.PieChart(document.getElementById(\'TopSource\'));";
say REPORT	'         chartSource.draw(dataSource, options);';
say REPORT	"         var TableSource = new google.visualization.Table(document.getElementById(\'TableSource\'));";
say REPORT	"         TableSource.draw(dataSource, {showRowNumber: true});";

######## Top Destinations
say REPORT	'         // Instantiate and draw our Top Sources IPS chart & table, passing in some options.';
say REPORT	"         var chartDestination = new google.visualization.PieChart(document.getElementById(\'TopDestination\'));";
say REPORT	'         chartDestination.draw(dataDestination, options);';
say REPORT	"         var TableDestination = new google.visualization.Table(document.getElementById(\'TableDestination\'));";
say REPORT	"         TableDestination.draw(dataDestination, {showRowNumber: true});";

########## Creating  the HTML body and the needed divisions.
say REPORT	'       }';
say REPORT	' 		 </script>';
say REPORT	'   </head>';


say REPORT	'   <body>';
say REPORT	'    <div class="Protocols">';
say REPORT	'    	<div id="TopProtocol"></div>';
say REPORT	'    	<div id="TableProtocol"></div>';
say REPORT	'    </div>';
say REPORT	'    <div class="Services">';
say REPORT	'    	<div id="TopService"></div>';
say REPORT	'    	<div id="TableService"></div>';
say REPORT	'    </div>';
say REPORT	'    <div class="Policies">';
say REPORT	'    	<div id="TopPolicy"></div>';
say REPORT	'    	<div id="TablePolicy"></div>';
say REPORT	'    </div>';
say REPORT	'    <div class="Sources">';
say REPORT	'    	<div id="TopSource"></div>';
say REPORT	'    	<div id="TableSource"></div>';
say REPORT	'    </div>';
say REPORT	'    <div class="Destinations">';
say REPORT	'    	<div id="TopDestination"></div>';
say REPORT	'    	<div id="TableDestination"></div>';
say REPORT	'    </div>';
say REPORT	'   </body>';
say REPORT	' </html>';
close REPORT or die $!;
}

sub Toprotocol{
#open the file config in read mode
open SESSIONS, "<sessions.txt" or die $!;
#creating hash to handle the tops
my %Top;
my @Temp;
my $remain=0;
#reading the session file line by line
while (<SESSIONS>) {
	if( $_!~ m/->/ && $_=~ m/^</ ){ 				#Get rid of symbolic links 
		#print $_;   				 
		@Temp = split (/;|,/, $_);	 #split it by commas according to sk65133
		$Temp[5]=~ s/^\s+0+//;			#remove starting spaces and ceros	
		$Top{$Temp[5]}++;			 #Extracting the protocol number
		$remain++;
	}
}

my @data;
my $count=0;
my $size= keys %Top;		#requesting the number of pairs in the hash
$size--;					#including the 0 in the count
if ($size > 4){				#If there are less than 4 (Top 5: 0 to 4 in the array) elements, use the current value
$size=4;
}
foreach ((sort {$Top{$b} <=> $Top{$a}} keys %Top) [0..$size]){
    $data [$count]= join ('-', hex $_, $Top{$_});				#Saving the protocol in DEC instead the original HEX notation
	$count++;
	$remain=$remain-$Top{$_};
}	
undef %Top;	

# Changing the values for the most common protocols, using http://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml, numbers saved are on hex
for (@data){
s/^1-/ICMP-/;		#ICMP
s/^2-/IGMP-/;		#IGMP
s/^6-/TCP-/;		#TCP
s/^17-/UDP-/;		#UDP
s/^47-/GRE-/;		#GRE
s/^89-/OSPF-/;		#OSPF
}

############## Creating the Data used in the charts
open REPORT, ">>Topgraphs.html" or die $!;

say REPORT	'         var dataProtocol = new google.visualization.DataTable();';
say REPORT	" 		  dataProtocol.addColumn(\'string\', \'Protocols\');";
say REPORT	"         dataProtocol.addColumn(\'number\', \'Sessions\');";
say REPORT	'         dataProtocol.addRows([';

my $Protocols;
my $Sessions;
for (@data){
($Protocols,$Sessions)=split(/-/);
	if($Protocols =~ m/^[0..9]/){
		say REPORT "\t\t[\'IP protocol $Protocols\', $Sessions],";
	}
	else{
		say REPORT "\t\t[\'$Protocols\', $Sessions],";
	}
}      
if ($remain > 0){say REPORT "\t\t[\'Other\', $remain],";}  
say REPORT	'         ]);';
close REPORT or die $!;
}

##############################
#		Top Services	######
##############################
sub Topservices{
#open the file config in read mode
open SESSIONS, "<sessions.txt" or die $!;
#creating hash to handle the tops
my %Top;
my @Temp;
my $remain=0;
while (<SESSIONS>) {
	if( $_!~ m/->/ && $_=~ m/^</ ){ 	#Get rid of symbolic links   				 
		@Temp = split (/;|,/, $_);		#split it by ; and , according to sk65133
		$Temp[5]=~ s/^\s+0+//;			#remove starting spaces and zeros	
		if ($Temp[5]=="6" or $Temp[5]=="11" ){		#Matching TCP or UDP
			$Temp[4]=~ s/^\s+0+//;			#remove starting spaces and zeros
			$Top{join(',', hex $Temp[5], hex $Temp[4])}++;				 #Extracting the protocol and the destination port in DEC (was in hex)
		}
		else{							#Counting the numbers of non TCP or UDP sessions
			$remain++;			
		}
	}
}

# Extracting the top 10 services
my @data;
my $count=0;
my $size= keys %Top;		#requesting the number of pairs in the hash
$size--;					#including the 0 in the count
	if ($size > 9){				#If there are less than 9 (Top 10: 0 to 9 in the array) elements, use the current value
		$size=9;
	}
foreach ((sort {$Top{$b} <=> $Top{$a}} keys %Top) [0..$size]){
    $data [$count]= join ('-', $_, $Top{$_});				#Saving the protocol and port
	$count++;
}	
undef %Top;	

## Converting the most common services into human readable
for (@data){
s/^6,21-/FTP-/;
s/^6,21-/SSH-/;
s/^6,25-/SMTP-/;
s/^6,80-/HTTP-/;		
s/^6,443-/HTTPS-/;	
s/^6,3389-/RDP-/;		
s/^17,53-/DNS-/;	
s/^17,123-/NTP-/;	
}

############## Saving the Services Data into the HTML
open REPORT, ">>Topgraphs.html" or die $!;
say REPORT	'         var dataService = new google.visualization.DataTable();';
say REPORT	" 		  dataService.addColumn(\'string\', \'Service\');";
say REPORT	"         dataService.addColumn(\'number\', \'Sessions\');";
say REPORT	'         dataService.addRows([';

my $Port;
my $Services;
my $Sessions;
my $Dummy;

for (@data){
($Services,$Sessions)=split(/-/);
	given ($Services){
		when (m/^6/)	{
			($Dummy, $Port) =split (/,/, $Services);
			say REPORT "\t\t['TCP port $Port\', $Sessions],";
		}
		when (m/^17/)	{
			($Dummy, $Port) =split (/,/, $Services);
			say REPORT "\t\t[\'UDP port $Port\', $Sessions],";
		}
		default		{say REPORT "\t\t[\'$Services\', $Sessions],";}
	}
}   
say REPORT "\t\t[\'Non TCP or UDP\', $remain],";
say REPORT	'         ]);';    
close REPORT or die $!;

}

sub Toppolicies{
#open the file config in read mode
open SESSIONS, "<sessions.txt" or die $!;
#creating hash to handle the tops
my %Top;
my @Temp;
my $remain=0;
while (<SESSIONS>) {
	if( $_!~ m/->/ && $_=~ m/^</ ){ 	#Get rid of symbolic links   				 
		@Temp = split (/;|,/, $_);	 	#split it by commas according to sk65133
		$Temp[8]=~ s/^\s+0+//;			#remove starting spaces and ceros	
		$Top{$Temp[8]}++;			 	#Extracting the policy ID number
		$remain++;
	}
}

# Extracting the top 10 Policies
my @data;
my $count=0;
my $size= keys %Top;			#requesting the number of pairs in the hash
$size--;						#including the 0 in the count
	if ($size > 9){				#If there are less than 9 (Top 10: 0 to 9 in the array) elements, use the current value
		$size=9;
	}
foreach ((sort {$Top{$b} <=> $Top{$a}} keys %Top) [0..$size]){
	$data [$count]= join ('-', hex $_, $Top{$_});				#Saving the policy ID in DEC instead the original HEX notation
	$count++;
	$remain=$remain-$Top{$_};
}	
undef %Top;	

############## Saving the Services Data into the HTML
open REPORT, ">>Topgraphs.html" or die $!;
say REPORT	'         var dataPolicy = new google.visualization.DataTable();';
say REPORT	" 		  dataPolicy.addColumn(\'string\', \'Policy ID\');";
say REPORT	"         dataPolicy.addColumn(\'number\', \'Sessions\');";
say REPORT	'         dataPolicy.addRows([';


my $Sessions;
my $Policy;
for (@data){
	($Policy,$Sessions)=split(/-/);
	say REPORT "\t\t[\'Policy ID $Policy\', $Sessions],";
} 
if ($remain > 0){say REPORT "\t\t[\'Other\', $remain],";}       
say REPORT	'         ]);';
close REPORT or die $!;
}


sub Topsources{
#open the file config in read mode
open SESSIONS, "<sessions.txt" or die $!;
#creating hash to handle the tops
my %Top;
my @Temp;
my $remain=0;
while (<SESSIONS>) {
	if( $_!~ m/->/ && $_=~ m/^</ ){ 	#Get rid of symbolic links   				 
		@Temp = split (/;|,/, $_);	 	#split it by commas according to sk65133
		$Temp[1]=~ s/^\s+0+//;			#remove starting spaces and ceros	
		$Top{join ('.', map { hex } $Temp[1] =~ /\w{2}/g)}++;			 	#Extracting the source IP and save it in dotted format
		$remain++;
	}
}

# Extracting the top 10 Source
my @data;
my $count=0;
my $size= keys %Top;			#requesting the number of pairs in the hash
$size--;						#including the 0 in the count
	if ($size > 9){				#If there are less than 9 (Top 10: 0 to 9 in the array) elements, use the current value
		$size=9;
	}
foreach ((sort {$Top{$b} <=> $Top{$a}} keys %Top) [0..$size]){
	$data [$count]= join ('-', $_, $Top{$_});				#Saving the source IP and it's counting
	$count++;
	$remain=$remain-$Top{$_};
}	
undef %Top;	

############## Saving the Sources Data into the HTML
open REPORT, ">>Topgraphs.html" or die $!;
say REPORT	'         var dataSource = new google.visualization.DataTable();';
say REPORT	" 		  dataSource.addColumn(\'string\', \'Source IP\');";
say REPORT	"         dataSource.addColumn(\'number\', \'Sessions\');";
say REPORT	'         dataSource.addRows([';


my $Sessions;
my $Source;
for (@data){
	($Source,$Sessions)=split(/-/);
	say REPORT "\t\t[\'$Source\', $Sessions],";
}      
if ($remain > 0){say REPORT "\t\t[\'Other\', $remain],";} 
say REPORT	'         ]);';
close REPORT or die $!;
}


sub Topdestinations{
#open the file config in read mode
open SESSIONS, "<sessions.txt" or die $!;
#creating hash to handle the tops
my %Top;
my @Temp;
my $remain=0;
while (<SESSIONS>) {
	if( $_!~ m/->/ && $_=~ m/^</ ){ 	#Get rid of symbolic links   				 
		@Temp = split (/;|,/, $_);	 	#split it by commas according to sk65133
		$Temp[3]=~ s/^\s+0+//;			#remove starting spaces and ceros	
		$Top{join ('.', map { hex } $Temp[3] =~ /\w{2}/g)}++;			 	#Extracting the source IP and save it in dotted format
		$remain++;
	}
}

# Extracting the top 10 Source
my @data;
my $count=0;
my $size= keys %Top;			#requesting the number of pairs in the hash
$size--;						#including the 0 in the count
	if ($size > 9){				#If there are less than 9 (Top 10: 0 to 9 in the array) elements, use the current value
		$size=9;
	}
foreach ((sort {$Top{$b} <=> $Top{$a}} keys %Top) [0..$size]){
	$data [$count]= join ('-', $_, $Top{$_});				#Saving the source IP and it's counting
	$count++;
	$remain=$remain-$Top{$_};
}	
undef %Top;	

############## Saving the Destinatios Data into the HTML
open REPORT, ">>Topgraphs.html" or die $!;
say REPORT	'         var dataDestination = new google.visualization.DataTable();';
say REPORT	" 		  dataDestination.addColumn(\'string\', \'Destination IP\');";
say REPORT	"         dataDestination.addColumn(\'number\', \'Sessions\');";
say REPORT	'         dataDestination.addRows([';


my $Sessions;
my $Destination;
for (@data){
	($Destination,$Sessions)=split(/-/);
	say REPORT "\t\t[\'$Destination\', $Sessions],";
}      
if ($remain > 0){say REPORT "\t\t[\'Other\', $remain],";} 
say REPORT	'         ]);';
close REPORT or die $!;
}


