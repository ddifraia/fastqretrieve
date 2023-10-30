#'@export
#'

#'@title FASTQretrive
#'@description a function for easy retrieving FASTQ files from
#'SRA and GEO accession. You need to have sra toolkit and fastq-dump on your
#'system to work properly
#'@param sra a vector of character of SRA
#'@param outdir a directory where you want to save your fastq files, must
#'be a FULL path, with no "/" at the end
#'@param ftp_path by default ftp://ftp.sra.ebi.ac.uk/vol1/srr, but you should
#'go to ENA https://www.ebi.ac.uk/ena/, type your sra id of interest
#'and go down to download and copy the link of the download to see exaclty
#'how FASTQ files are stored.

FASTQretrieve <- function(sra,out,fpt_path="ftp://ftp.sra.ebi.ac.uk/vol1/srr")
{
  #create directory if does not exists
  if(!dir.exists(out)){dir.create(out)}
  if(!dir.exists(file.path(out,"sra"))){dir.create(file.path(out,"sra"))}
  if(!dir.exists(file.path(out,"fastq"))){dir.create(file.path(out,"fastq"))}

  sra_path <- file.path(out,"sra")
  fastq_path <- file.path(out,"fastq")

  browser()

  #command
  for (sr in sra) {
    message("Currently downloading ",sr,"...")

    # #build ftp command, is faster
    path1 <- stringr::str_sub(sr,1,6)
    path2 <- paste("0",stringr::str_sub(sr,10,11),sep = "")
    ftp_command <- file.path(fpt_path,path1,path2,sr)

    #run ftp command
    command <- paste("(cd ",sra_path,"; ","wget ",ftp_command,") 2>&1 | while read line; do echo -n -e \"\\r$line\"; done",sep = "")
    res <- system(command,intern = FALSE)
  }

  #extract fastq
  for (sr in sra){
    message("Currently FASTQdumping ",sr,"...")
    fastq_cmd = paste("fasterq-dump"," -O ",fastq_path," ",sra_path,"/",sr,sep = "")
    system(fastq_cmd)
  }

}

#'@export


#'@title FASTQdump
#'@description in case you have already save the SRA file your can run this
#command directly to just use fastqdump on that directory. Important every
#it automatically grep in the folder every file that starts with SRR

FASTQdump <- function(dir="",outdir="")
{
  #list all files
  sras <- list.files(dir,full.names = TRUE)
  print(sras)

  #cycle and dump each file
  for(sr in sras)
  {
    message("Currently FASTQdumping ",sr,"...")
    fastq_cmd = paste("fasterq-dump"," -O ",outdir," ",sr,sep = "")
    system(fastq_cmd)
  }
}

#'@export

#'@title exampleSRA
#'@description load a simple file with some SRA annotation, return it
#'as a data.frame

exampleSRA <- function()
{
  f <- system.file("SraRunTable.txt",package = "fastqretrieve")
  f <- read.csv(f)
  return(f)
}

#'@export
