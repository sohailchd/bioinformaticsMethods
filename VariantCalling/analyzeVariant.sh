### running the docker version of the deepvariant 
### 1. Install docker
### 2. Run the docker image with reference and target genome 



######################################################################################
############################ install docker ##########################################
BIN_VERSION="0.8.0"

sudo apt -y update
sudo apt-get -y install docker.io
sudo docker pull gcr.io/deepvariant-docker/deepvariant:"${BIN_VERSION}"

######################################################################################
############################ running the docker imgae ###############################

OUTPUT_DIR="${PWD}/variant_output"
INPUT_DIR="${PWD}"
mkdir -p "${OUTPUT_DIR}"



sudo docker run \
  -v "${INPUT_DIR}":"/" \
  -v "${OUTPUT_DIR}":"/" \
  gcr.io/deepvariant-docker/deepvariant:"${BIN_VERSION}" \
  /opt/deepvariant/bin/run_deepvariant \
  --model_type=WGS \
  --ref=GRCh38.primary_assembly.genome.fasta \
  --reads=GRCh38.primary_assembly.genome.bam \
  --output_vcf=/output.vcf.gz \
  --output_gvcf=/output.g.vcf.gz 