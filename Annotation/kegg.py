import requests
import csv 

'''
    c("trans", "sp", "qlen", "slen", "bitscore", "length", "nident", "pident", "evalue", "ppos")
'''

def get_kegg_id(sp):
    '''
        base_url = http://rest.kegg.jp/conv/genes/uniprot: + (sp)
        > sometimes there are more than one lines in output return them as list (P68431)
    '''
    try:
        print(">",sp)
        kegid = requests.get("http://rest.kegg.jp/conv/genes/uniprot:"+sp).text
        print(kegid)
        if kegid == "\n":
            return None
        kid = kegid.split("\t")
        klist = []
        if len(kid)>2:
            for i in range(1,len(kid)):
                klist.append(kid[i].split('\n')[0])
            return klist
        return [kid[1]]
    except Exception as e:
        print("ERROR "+str(e))
        print("error while fectching kegg_id for %s",sp)
    return None 



def get_ko_id(kid):
    '''
        base_url = http://rest.kegg.jp/link/ko/ + (kid)
    '''
    try:
        print(">",kid)
        ko_r = requests.get("http://rest.kegg.jp/link/ko/"+kid).text
        if ko_r == "\n":
            return None 
        print("ko > ",ko_r)
        ko = ko_r.split("\t")[1]
        return ko
    except Exception as e:
        print("ERROR "+str(e))
        print("error while fectching ko for %s",kid)
    return None 


def get_path_ways(ko):
    '''
        base_url = http://rest.kegg.jp/link/pathway/ + ko
    '''
    try:
        print(">",ko)
        path_r = requests.get("http://rest.kegg.jp/link/pathway/"+ko).text 
        print(path_r)
        if path_r == "\n":
            return None
        ## create a path list 
        split_path = path_r.split("\t")
        tmps = []
        for i in range(1,len(split_path)):
            tmps.append(split_path[i].split('\n')[0])

        return tmps
    except Exception as e:
        print("ERROR"+str(e))
        print("error while fetching pathways for :  %s",ko)



def get_pathway_description(plist):
    '''
        base url : http://rest.kegg.jp/list/pathway: + <ko04120/map04912>
        retrives the pathway descriptions for all the
        pathway ids 
    '''
    print(">",plist)
    desc_list = {}
    if not plist:
        print("empty plist",plist)
        return None
    for p in plist:
        path = p.split(":")[1]
        print(path)
        r = requests.get("http://rest.kegg.jp/list/pathway:"+path).text
        if r != "\n":
            r = r.split()[1]
            desc_list.update({p:r})
    return desc_list




def annotate():
    '''
        nident/slen > .9
    '''
    dfile = open("transcriptBlast.txt")
    for line in dfile:
        cols = line.split()
        cov = float(cols[6])/float(cols[3])
        if cov > float(0.9):   #and (float(cols[8]) < float("1e-180"))
            kid = get_kegg_id(cols[1])
            if kid:
                for kids in kid:
                    ko  = get_ko_id(kids)
                    print("[info] : ",ko)
                    if ko:
                        pathways = get_path_ways(ko)
                        pdec = get_pathway_description(pathways)
                        if pdec:
                            for path,pds in pdec.items():
                                yield [cols[1],kid,ko,path,pds]

            print("---------------------------------------------------------------")
    dfile.close()



if __name__ == "__main__":
    with open('annotations.csv','w') as out:
        csv_out=csv.writer(out)
        csv_out.writerow(['sp','keggid','ko','pathway','pathway-desc'])
        for row in annotate():
            print(row)
            csv_out.writerow(list(row))