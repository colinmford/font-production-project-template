from fontTools.ttLib import TTFont
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("font")
    parser.add_argument("-o", "--out")
    args = parser.parse_args()
    
    if args.font:
        ttFont = TTFont(args.font)
        
        if 'fpgm' in ttFont:
            ttFont["head"].flags |= 1 << 3
            
        if args.out:
            out = args.out
        else:
            out = args.font
        
        ttFont.save(out)
    
    print("\tAdded Head Flag to Hinted TT Font: %s" % out)


if __name__ == "__main__":
    main()