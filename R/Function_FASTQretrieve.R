#'@export
#'

#'@title FASTQretrive
#'@description a function for easy retrieving FASTQ files from
#'SRA and GEO accession. You need to have sra toolkit and fastq-dump on your
#'system to work properly
#'@param sra a vector of character of SRA
#'@param outdir a directory where you want to save your fastq files, must
#'be a FULL path, with no "/" at the end

FASTQretrieve <- function(sra,out)
{
  #create directory if does not exists
  if(!dir.exists(out)){dir.create(out)}
  if(!dir.exists(file.path(out,"sra"))){dir.create(file.path(out,"sra"))}
  if(!dir.exists(file.path(out,"fastq"))){dir.create(file.path(out,"fastq"))}

  sra_path <- file.path(out,"sra")
  fastq_path <- file.path(out,"fastq")

  #command
  for (s in sra) {
    message("Currently downloading ",s,"...")
    command <- paste("cd ",sra_path,"; prefetch ",s,sep = "")
    system(command)
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
