# -*- coding: utf-8 -*-

from jinja2 import Template, Environment, FileSystemLoader
from cStringIO import StringIO
import sys, os


PAT_FILE_FOLDER = "pat"


def parse_command_line(needed_args_list):
    # for version compatible
    # needed_args_list should be a list containing tuples with args and kwargs that parser accepts
    # e.g. [(args, kwargs), ...], args is a list containing arguments, 
    # and kwargs means keyword-args that using a dict to do the same thing
    try:
        # for python version >= 2.7
        import argparse
        parser = argparse.ArgumentParser()
        for args, kwargs in needed_args_list:
            parser.add_argument(*args, **kwargs)
        args = parser.parse_args()
        return args

    except ImportError, ex:
        import optparse
        parser = optparse.OptionParser()
        for args, kwargs in needed_args_list:
            parser.add_option(*args, **kwargs)
        options, args = parser.parse_args()
        return options



def gen(args):
    pat_name = args.input
    out_file = args.output
    env = Environment(loader=FileSystemLoader(PAT_FILE_FOLDER))
    template = env.get_template(pat_name)

    if out_file:
        with open(out_file, "w") as fp:
            fp.write(template.render().encode("utf8"))
    else:
        #print template.render()
        out_file = pat_name
        with open(out_file, "w") as fp:
            fp.write(template.render().encode("utf8"))



if __name__ == "__main__":
    args = parse_command_line([
        (["-i", "--input"], {"dest": "input", "action": "store"}),
        (["-o", "--output"], {"dest": "output", "action": "store"}),
        #(["--is_true"], {"dest": "is_true", "action": "store_true"}),
    ])

    if not args.input:
        print u"缺少模板文件"
        sys.exit(-1)

    gen(args)
