#!/usr/bin/env python2
# -*- coding: UTF-8  -*-

"""
Wrapper for contact_fcc

Calculates residue contacts between different chains
of a single structure.

João Rodrigues @ Utrecht, 2012
"""

from subprocess import Popen, PIPE
import os
import sys


def _calculate_contacts(executable, pdbfile, d_cutoff):
    """
    Outputs a list of residue contacts based on distance analysis
    of the PDB file.
    
    Arguments:
    executable  - path to contact calculation program
    pdbfile     - path to PDB-formatted file (.pdb extension)
    d_cutoff    - minimal distance in A to consider a contact between two atoms (float)
    """
    
    pdbname = os.path.basename(pdbfile)[:-4]
    outfile = os.path.join(os.path.dirname(pdbfile), "%s.contacts" %pdbname)

    p = Popen([executable, pdbfile, d_cutoff], stdout=PIPE)
    p_output = p.communicate()[0]
    contacts = sorted(list(set([l for l in p_output.split('\n')][:-1])))
    
    f_contact = open(outfile, 'w')
    f_contact.write('\n'.join(contacts))
    f_contact.close()

    return 0
    
if __name__ == '__main__':

    import optparse
    
    USAGE = "%s [-f structures.txt] [-c 5.0] file1.pdb file2.pdb"

    # Get haddock tools location from env
    #ht_path = os.getenv('HADDOCKTOOLS')
    ht_path = "./tools"
    
    if not ht_path:
        sys.stderr.write('!! HADDOCKTOOLS is not defined.\n')
        sys.exit(1)

    parser = optparse.OptionParser(usage=USAGE)
    parser.add_option('-c', '--cutoff', dest="d_cutoff", action='store', type='string',
                        default="5.0", 
                        help='Distance cutoff to evaluate contacts. [default: 5.0A]')
    parser.add_option('-f', '--file', dest="input_file", action='store', type='string',
                        help='Input file (one file path per line)')
    parser.add_option('-e', '--exec', dest="executable", action='store', type='string',
                        default=os.path.join(ht_path, 'contact_fcc'), 
                        help='Path to the executable C++ program to calculate contacts [default: ./contact_fcc]')

    (options, args) = parser.parse_args()

    if options.input_file:
        args = [name.strip() for name in open(options.input_file) if name.strip()]
    
    if not args:
        sys.stderr.write("!! No files provided. Exiting. \n")
        sys.stderr.write(USAGE+'\n')
        sys.exit(1)
    
    # Convert to full paths
    args = map(os.path.abspath, args)    
    cutoff = options.d_cutoff

    executable = os.path.abspath(options.executable)
    if not os.path.exists(executable):
        print "Path not found: %s" %executable
        sys.exit(1)

    for struct in args:    
        _calculate_contacts(executable, struct, cutoff)
