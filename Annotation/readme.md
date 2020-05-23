## Annotation 
Objectives  
```
- Retrieve KEGG IDs for every SwissProt ID in your BLAST output where nident/slen > .9
- Retrieve the KEGG ortholog (KO) for every species KEGG ID
- Retrieve the KEGG pathways for every KEGG ortholog (KO)
- Retrieve the KEGG pathway descriptions for every KEGG pathway ID
- Merge the results into a table with Transcript ID, KO, Pathway IDs, and Pathway descriptions.
```

### 1. Align transcript to SwissProt   (blastTranscripts.sh)
Using blastx tool we converted the 'trinity.fasta' into respective SwissProt transcript.   
We can customize the output format using '-outfmt' and mention all the column names we require.   
Once we have the tanscript output in 'transcriptBlast.txt' we can proceed with the next steps.     


### 2. Creating annotation using Python script 'kegg.py'
Next we will create a python script which will query the KEGG DB using http requests and create a csv   
table which will be saved in 'annotations.csv'.

#### Steps :
```
1. Open the 'transciptBlast.txt' file in python and read the rows.
2. Make sure nident/slen > .9   
3. Next we will use the following http requests to fectch the data from KEGG     
    - http://rest.kegg.jp/conv/genes/uniprot:sp  Returns the respective KEGG IDs    
    - http://rest.kegg.jp/link/ko/ + (kid)       Returns the KEGG ortholog for protein 'kid'   
    - http://rest.kegg.jp/link/pathway/ + ko     Returns the Pathway for 'ko'
    - http://rest.kegg.jp/list/pathway: + <ko04120/map04912>    Returns the pathway descriptions for map/ko 
4. Once we verify the data is not empty and perfect we will dump them row by row in csv file.  
   Make sure all the pathway descriptions are saved as indiviual rows.
5. Following are the respective methods in python script 'kegg.py'
        annotate()
            |--- if (nident/slen > .9)
                   |-- get_kegg_id()
                        |-- get_ko_id()
                            |-- get_path_ways()
                                |-- get_pathway_description()
6. All the output will be saved in 'annotations.csv' and stdout will be redirected to 'annotations.log'
7. Verify if there was any error using 'cat annotations.log | grep ERROR'
```  
