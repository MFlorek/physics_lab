"""Generates pdf files with simulations of physical experiments. The list of experiments:
T22 - Melting of ice in a calorimeter (calculation of latent heat of ice and changes of entropy)
M2 - Archimedes principle
M4 -

PDF files can be prepared on the basis of a list of students or as a generic set of n files.
"""
#-*- coding: utf-8 -*-
import numpy as np
import random
from random import uniform
import jinja2
from jinja2 import Template
from jinja2 import Environment, FileSystemLoader
import tempfile, os
import re
import shutil
import math
#from pandas import DataFrame, read_csv
import matplotlib as plt
import pandas as pd
import numpy as np
import re, sys
from time import sleep

def students_ids(file: str=None, n: int=10) -> dict:
    result = {}
    if file == None:
        result = {'1': list(range(1,n+1))}
    else:
        d = os.path.dirname(os.getcwd())
        src_file = os.path.join(d, 'student_list.csv')
        df = pd.read_csv(src_file, sep=';')
        if df['gr']:    #if there are several groups of students
            for group in range(1, df['gr'].max()+1):
                mask = df['gr'] == group
                ids = df[mask]['indeks'].tolist()
                result[str(group)]=ids
        else:
            result['1'] = df['indeks']
    return result



if __name__ == '__main__':

    #customization
    settings['footnote_text'] = ''
    settings['header_text_left'] = ''
    settings['header_text_margin'] = ''
    students_list = students_ids(file='student_list.csv')  #provide either filename or number of generic sets to be generated
    experiments = [M2, T22]

    latex_jinja_env = jinja2.Environment(
        block_start_string='\BLOCK{',
        block_end_string='}',
        variable_start_string='\VAR{',
        variable_end_string='}',
        comment_start_string='\#{',
        comment_end_string='}',
        line_statement_prefix='%%',
        line_comment_prefix='%#',
        trim_blocks=True,
        autoescape=False,
        loader=jinja2.FileSystemLoader(os.path.abspath('.'))
    )
    env = Environment(loader=FileSystemLoader('.'))

    for exp in experiments:
        exp(students_list, settings)


