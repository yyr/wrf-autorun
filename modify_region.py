#!/usr/bin/env python3.2

# make an class for domain
#
# takes input file
# replace

import fileinput

class prepareReadWrfNc:
    """prepares a read_wrf_nc_{1,2,3}.f files
    for a given region
    """
    hok  = ['82:122,66:103','83:216,14:118','1:310,1:178']
    saka  = ['95:116,106:158','125:174,124:220','60:201,180:250']
    ffile = "read_wrf_nc.f"

    def __init__(self):
        """
        Arguments:
        - `reg`: region name eg: hok,saka
        """
        self.flines = []

    def read_wrf_nc():
        """ reads the file
        """
        self.fin = open(self.ffile,"r")
        self.lines = self.fin.read()
        return self.lines

    def mod_reg():
        """ modify region with
        regular expression
        """
        pass


    def write_out_nc(self,region):
        """ take input for which region to process
        modify/construct file line for that domain
        """
        if reg == "hok":
            self.dom = self.hok
        elif reg == "saka":
            self.dom == self.saka
        else:
            raise "unknow region"

        for dom_dey in self.dom:
            self.lnes = self.read_wrf_nc




hok_region = prepareReadWrfNc()
lines = hok_region.read_wrf_nc()

print(type(lines))

# for line in lines:
#     print(line)

# infile = 'read_wrf_nc.f'
# ofile = "test"

# fin = open(infile,"r")
# fout = open(ofile,"w")
# lines=fin.read()

# ends here
