##############################################################################
#
#  The API is formally specified, but in practice, best results come from experimentation
#  and following the not-always-consistent examples provided in documentation.
#
#  Accordingly here, testing is based on those examples, which are provided as URLs.
#  The URLs are listed below as of April 2014.
#  Changes to these examples might require also changing the examples of call.MGRAST.Rd.
#
#  https://api.mg-rast.org/annotation/sequence/mgm4447970.3?evalue=10&type=organism&source=SwissProt
#  https://api.mg-rast.org/annotation/similarity/mgm4447970.3?identity=80&type=function&source=KO
#  https://api.mg-rast.org/compute/alphadiversity/mgm4447970.3?level=order
#  https://api.mg-rast.org/download/mgm4447970.3?file=350.1
#  https://api.mg-rast.org/download/mgm4447970.3?stage=650
#  https://api.mg-rast.org/library?limit=20&order=name
#  https://api.mg-rast.org/library/mgl52924?verbosity=full
#  https://api.mg-rast.org/m5nr/ontology?source=Subsystems&min_level=level3
#  https://api.mg-rast.org/m5nr/taxonomy?filter=Bacteroidetes&filter_level=phylum&min_level=genus
#  https://api.mg-rast.org/m5nr/sources
#  https://api.mg-rast.org/m5nr/accession/YP_003268079.1
#  https://api.mg-rast.org/m5nr/alias/IPR001478
#  https://api.mg-rast.org/m5nr/md5/000821a2e2f63df1a3873e4b280002a8?source=InterPro
#  https://api.mg-rast.org/m5nr/function/sulfatase?source=GenBank
#  https://api.mg-rast.org/m5nr/organism/akkermansia?source=KEGG
#  https://api.mg-rast.org/m5nr/sequence/MAGENHQWQGSIL?source=TrEMBL
#  https://api.mg-rast.org/matrix/organism?id=mgm4447970.3&id=mgm4447192.3&id=mgm4447102.3&id=mgm4447103.3&group_level=family&source=RefSeq&result_type=abundance&evalue=15
#  https://api.mg-rast.org/matrix/function?id=mgm4447970.3&id=mgm4447192.3&id=mgm4447102.3&id=mgm4447103.3&group_level=level3&source=Subsystems&result_type=abundance&identity=80&filter_level=phylum&filter=Firmicutes
#  https://api.mg-rast.org/matrix/feature?id=mgm4447970.3&id=mgm4447192.3&id=mgm4447102.3&id=mgm4447103.3&source=KEGG&result_type=evalue&length=25
#  https://api.mg-rast.org/metadata/template
#  https://api.mg-rast.org/metadata/cv
#  https://api.mg-rast.org/metadata/export/mgp128
#  https://api.mg-rast.org/metagenome?limit=20&order=name
#  https://api.mg-rast.org/metagenome/mgm4447970.3?verbosity=metadata
#  https://api.mg-rast.org/project?limit=20&order=name
#  https://api.mg-rast.org/project/mgp128?verbosity=full
#  https://api.mg-rast.org/sample?limit=20&order=name
#  https://api.mg-rast.org/sample/mgs25823?verbosity=full
#  https://api.mg-rast.org/validation/template/
#  https://api.mg-rast.org/validation/data/?template=
#
#  CRAN asks that tests not actually communicate with MG-RAST.
#  "Live" tests are below for development, but in comments for CRAN.
#
#  So the sense of "testing" on CRAN is very limited.
#  Only the package is tested : the API is not meaningfully tested.
#  Indeed the package "works" even when the API does not work as expected,
#  for instance due to an actual change, server downtime, or any unexplained glitch.
#
##############################################################################


library(MGRASTer)

#-----------------------------------------------------------------------------
#  test package environment & local API representation.
#  also, test access and slicing of documentation.
#  we would like a simpler way to list controlled vocabularies
#  than the last two examples, but that must wait.
#-----------------------------------------------------------------------------

ls (.MGRAST)
get ("server", envir=.MGRAST)
get ("this.package", envir=.MGRAST)
get ("API.version", envir=.MGRAST)
get ("API", envir=.MGRAST)
API <- get ("API", envir=.MGRAST)

#-----------------------------------------------------------------------------
#  test API calls ! 
#
#  the first set are calls from API documentation, adapted by hand, April 2014.
#  some are copied in the doc examples of call.MGRAST() and parse.MGRAST().
#  if these are updated, so should those be.  (see above for the original URLs.)
#
#  the second set are test cases put together by hand.
#  calls intended to produce errors are "try"d.
#-----------------------------------------------------------------------------

## Use the Travis / GitHub integrations to suppress these tests in the CRAN test
## environment.  This environment variable to "yes" in .travis.yml in CRAN:
##
## Set this variable manually if you want to run the tests
##
if (Sys.getenv("RunFOAASTests=yes") == "yes")

{

call.MGRAST ('an', 'se', id=4447970.3, ev=10, ty='or', so='Sw', destfile="no.file", issue=FALSE)   # Too slow
call.MGRAST ('an', 'si', id=4447970.3, iden=80, ty='fu', so='KO', destfile="no.file", issue=FALSE) # Too slow 
call.MGRAST ('co', 'al', id=4447970.3, le='or', issue=TRUE) # MGRASTer: resource missing component(s): url 
call.MGRAST ('do', 'ins', id=4447970.3, fi=350.1, destfile="no.file", issue=FALSE)  # Too slow
call.MGRAST ('do', 'se', id=4447970.3, st=650, issue=FALSE)  # MGRASTer: resource missing component(s): stage_id stage_name file_id stage_type file_name 
call.MGRAST ('li', 'qu', lim=20, or='na', issue=TRUE)
call.MGRAST ('li', 'ins', id=52924, ve='fu', issue=TRUE) # MGRASTer: resource missing component(s): sequencesets 
call.MGRAST ('m5', 'on', so='Subsystems', mi='level3', issue=TRUE)
call.MGRAST ('m5', 'ta', filter='Bacteroidetes', filter_l='phylum', mi='genus', issue=TRUE)
call.MGRAST ('m5', 'so', issue=TRUE)
call.MGRAST ('m5', 'ac', id='YP_003268079.1', issue=TRUE) #  call.MGRAST ('m5', 'al', text='IPR001478', issue=TRUE)   # RETIRED funcitonality
call.MGRAST ('m5', 'md', id='000821a2e2f63df1a3873e4b280002a8', so='InterPro', issue=TRUE)
call.MGRAST ('m5', 'fu', text='sulfatase', so='GenBank', issue=TRUE)
call.MGRAST ('m5', 'or', text='akkermansia', so='KEGG', issue=TRUE)
call.MGRAST ('m5', 'se', text='MAGENHQWQGSIL', so='TrEMBL', issue=TRUE)
call.MGRAST ('ma', 'or', id=c(4447970.3, 4447192.3, 4447102.3, 4447103.3), gro='family', so='Ref', resu='ab', ev=15, issue=TRUE)
call.MGRAST ('ma', 'fu', id=c(4447970.3, 4447192.3, 4447102.3, 4447103.3), gro='level3', so='Sub', resu='ab', iden=80, filter_l='phylum', filter='Firmicutes', issue=TRUE)
call.MGRAST ('ma', 'fu', id=c(4447970.3, 4447192.3, 4447102.3, 4447103.3), so='KO', resu='ev', len=25, issue=TRUE)
call.MGRAST ('metadata', 'te', issue=TRUE)
call.MGRAST ('metadata', 'cv', issue=TRUE)
call.MGRAST ('metadata', 'ex', id="mgp128", issue=TRUE)
call.MGRAST ('metageno','qu', lim=20, ord='name', issue=TRUE)
call.MGRAST ('metageno','ins', id=4447970.3, ve='me', issue=TRUE)
call.MGRAST ('proj', 'qu', lim=20, or='na', issue=TRUE)
call.MGRAST ('proj', 'ins', id=128, ve='fu', issue=TRUE)
call.MGRAST ('sa', 'qu', lim=20, or='na', issue=TRUE)
call.MGRAST ('sa', 'ins', id=25823, ve='fu', issue=TRUE)
call.MGRAST ('va', 'te', issue=TRUE)
call.MGRAST ("ann", "info", issue=TRUE)
call.MGRAST ("ann", "seque", destfile="no.file", issue=TRUE)
call.MGRAST ("compu", "alpha", issue=TRUE)
call.MGRAST ("downloa", "setl", issue=TRUE)
call.MGRAST ("downloa", "setl", id=4447970.3, issue=TRUE) 
call.MGRAST ("download", "setlist", st=300, id=4447970.3, id=4447192.3, issue=TRUE)
call.MGRAST ("download", "setlist", stage=300, id=4447970.3, id=4447192.3, issue=TRUE)
call.MGRAST ("mat", "org", id=4447970.3, issue=TRUE)
call.MGRAST ("mat", "func", id=4447970.3, filter="escherichia", issue=TRUE)
call.MGRAST ("mat", "func", id=4447970.3, filter="escherichia", issue=TRUE)
call.MGRAST ("mat", "func", id=4447970.3, filter="escherichia", filter_l="family", issue=TRUE)  # FAIL
call.MGRAST ("mat", "func", id=4447970.3, filter="escherichia", filter_l="family", filter_s="SEED", issue=TRUE) # FAIL

}   # end of live API-calling tests

#-----------------------------------------------------------------------------
#  test calls retrieving info pages
#-----------------------------------------------------------------------------
# 
# for (xx in names (API)) {
# 	if (!inherits (try (call.MGRAST (xx, 'info', verify=FALSE)), "try-error")) {
# 		message ("\'info\' call successful for: ", xx)
# 	} else
# 		message ("\'info\' call failed for: ", xx)
# 	}

#-----------------------------------------------------------------------------
#  test parsing of URLs from API documentation, without issuing calls.
#-----------------------------------------------------------------------------

flat.API <- unlist (get ("API", .MGRAST))
ee <- flat.API [grep("example", names(flat.API), fixed=T)]
ee <- unname(ee) [substr(ee, 1, 4) == "http"]

for (xx in ee) {
	message ("Parsing test URL: ", xx)
	str (try (parse.MGRAST (xx)))
	}

#-----------------------------------------------------------------------------
#  test parsing of URLS from API documentation [and the calls themselves]
#  for simplicity, we send all results to file,
#  rather than bothering to identify cases where that's definitely required.
#-----------------------------------------------------------------------------

ff <- list()
for (xx in ee) {
	li <- parse.MGRAST (xx)
	ff [[xx]] <- tempfile (li$resource)
	li [c ('quiet', 'destfile', 'issue')] <- list (TRUE, ff [[xx]], FALSE)
	res <- try (do.call (call.MGRAST, li))	
	if (xx == res) {
		message ('Matched URL: ', xx)
	} else
		message('Unmatched URL:\n\t', xx, '\n\t', res)

#	li$issue <- TRUE
#	try (do.call (call.MGRAST, li))

	}
print (unlist (unname (ff)))
sapply (ff, unlink)

