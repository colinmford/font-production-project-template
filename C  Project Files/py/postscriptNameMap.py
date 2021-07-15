def generatePostscriptNameMap(glyphList):
    """
    Generate a PostScript Name Map to be stored in the "public.postscriptNames" lib.

    Used to rename glyphs during generation, like so:

    {"indianrupee.tab": "uni20B9.tab"}

    Args:
        glyphList (list): A list of Glyph objects or a Font object (Defcon or FontParts)
        AGL (bool): Keep the names that appear in the Adobe Glyph List the same
    """
    from fontTools.agl import UV2AGL
    import re

    unicodeMap = {}
    unicodeMap.update(UV2AGL)

    # 1. Make a map from old glyph order to new glyph order
    renameMap = dict(zip([glyph.name for glyph in glyphList], [glyph.name for glyph in glyphList]))

    # 2. For every glyph that has a unicode, make a unicode name for it
    #    unless AGL is enabled, use the Adobe-given names for that
    for g in glyphList:
        u = g.unicode
        if u:
            if u in unicodeMap.keys():
                renameMap[g.name] = unicodeMap[u]
            else:
                renameMap[g.name] = "uni%04X" % u

    # 3. Now go through all the glyphs that have not been mapped yet
    #    and split them into parts. If they are more than 1 part, run through
    #    each part and use the existing map to rename that part to what it
    #    should be. i.e.
    #       "indianrupee.tab" -> ["indianrupee", ".", "tab"] -> ["uni20B9", ".", "tab"] -> "uni20B9.tab"
    #    resulting in the map:
    #       "indianrupee.tab": "uni20B9.tab"

    for k,v in renameMap.items():
        if k == v:
            splitName = re.split(r"((?<!^)[\W\_\-]+)", k)
            if len(splitName) > 1:
                for i, n in enumerate(splitName):
                    if n in renameMap.keys():
                        splitName[i] = renameMap[n]

                recomposed = "".join(splitName)

                renameMap[k] = recomposed

    # 4. Return only the items that are different
    return {k:v for k,v in renameMap.items() if k != v}
    
    
f = CurrentFont()
f.lib["public.postscriptNames"] = generatePostscriptNameMap(f)
print(f.lib["public.postscriptNames"])
print("Done!")