from fontTools.ttLib import TTFont
import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("font")
    parser.add_argument("-o", "--out")
    args = parser.parse_args()
    
    if args.font:
        ttFont = TTFont(args.font)
        ttFont["name"].removeNames(platformID=1)
        ttFont["name"].removeNames(nameID=18)
        
        if args.out:
            out = args.out
        else:
            out = args.font
        
        ttFont.save(out)
    
    print("\tRemoved Mac Names: %s" % out)


if __name__ == "__main__":
    main()