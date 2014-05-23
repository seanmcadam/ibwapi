ibwapi
======

Infoblox WAPI tools

Open up a connection to the server for an object type $ib = IBWAPI::Network->new(...)

Main Functions
$ib->GET() - Retireve/search for object by fields, or REF
$ib->POST() - Add an object specifinying fields
$ib->PUT() - Push changes to server for an object by REF
$ib->DELETE() - Delete object by REF

$ib->get_field( REF, $FIELD|$FIELD_REF )
	Get the field value for the REF, retrieve the files if no cached
