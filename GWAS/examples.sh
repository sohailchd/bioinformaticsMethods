## Getting started 
plink --file hapmap1


# Making a binary PED file
plink --file hapmap1 --make-bed --out hapmap1

#  you wanted to create a new file that only includes individuals with high genotyping 
#  (at least 95% complete), you would run:
plink --file hapmap1 --make-bed --mind 0.05 --out highgeno



# Working with the binary PED file
plink --bfile hapmap1
cat plink.log


# Summary statistics: missing rates
plink --bfile hapmap1 --missing --out miss_stat


# To perform a stratified analysis, use the --within option.
plink --bfile hapmap1 --freq --within pop.phe --out freq_stat

head miss_stat.lmiss

# If we were just interested in a specific SNP, and wanted to know what the frequency was in the two populations, you can use the --snp option to select this SNP:
plink --bfile hapmap1 --snp rs1891905 --freq --within pop.phe --out snp1_frq_stat

# one could simply use the available command line tools to sort the list of association statistics 
# and print out the top ten 
sort --key=7 -nr as1.assoc | head

# Genotypic and other association models
plink --bfile hapmap1 --model --snp rs2222162 --out mod1
head mod1.model 

## Stratification analysis
plink --bfile hapmap1 --cluster --mc 2 --ppc 0.05 --out str1
head str1.cluster1

## Association analysis, accounting for clusters
plink --bfile hapmap1 --mh --within str1.cluster2 --adjust --out aac1
more aac1.cmh.adjusted
plink --bfile hapmap1 --cluster --K 2 --out version3

## Quantitative trait association analysis
plink --bfile hapmap1 --assoc --pheno qt.phe --out quant1

## We request clustered permutation as follows, using the original pairing approach to matching:
plink --bfile hapmap1 --assoc --pheno qt.phe --perm --within str1.cluster2 --out quant2

## Extracting a SNP of interest
## plink --bfile hapmap1 --snp rs2222162 --recodeAD --out rec_snp1
