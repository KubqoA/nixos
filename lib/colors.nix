{ lib, ... }:

let
  inherit (builtins) elemAt listToAttrs substring;
  inherit (lib) concatStringsSep fixedWidthString nameValuePair
                stringToCharacters sublist toInt toUpper zipListsWith;
  inherit (lib._) joinWithSep;
in rec {
  /* Converts a hex color string to RGB triplet, an array of exactly 3 elements

     Type:
       toRGB :: String -> [Int]

     Example:
       toRGB "ffFFff"
       => [ 255 255 255 ]
  */
  toRGB = hex: let
    chars = stringToCharacters hex;
    r = sublist 0 2 chars;
    g = sublist 2 2 chars;
    b = sublist 4 2 chars;
    /* Converts a pair of characters (array of two strings, each of one char
       long) in hexadecimal to a number. Expects a valid hexadecimal string.

       Type:
         hexPairToNum :: [String] -> Int
       
       Example:
         hexPairToNum [ "F" "1" ]
         => 241
    */
    hexPairToNum = pair: let
      c1 = elemAt pair 0; c2 = elemAt pair 1;
      hexMapping = {
        "A" = 10;
        "B" = 11;
        "C" = 12;
        "D" = 13;
        "E" = 14;
        "F" = 15;
      };
      toNum = c: if hexMapping ? ${toUpper c} then hexMapping.${toUpper c} else toInt c;
    in 16 * (toNum c1) + (toNum c2);
  in [
    (hexPairToNum r)
    (hexPairToNum g)
    (hexPairToNum b)
  ];

  /* Both ‹hexColor› and ‹rgbColor› accept a color in 6 char long hexadecimal
     representation. Their variants ‹hexColor'› and ‹rgbaColor› accept an
     additional parameter ‹opacity› specified as an int in range from 0 to 100.
  */
  
  /* Type:
       hexColor :: String -> String
     
     Example:
       hexColor "FECACA"
       => "#FECACA"
  */
  hexColor = color: "#" + color;

  /* Type:
       hexColor' :: String -> Int -> String
     
     Example:
       hexColor' "FECACA" 54
       => "#FECACA54"
  */
  hexColor' = color: opacity: "#" + color + toString opacity;

  _rgbColor = color: extra: "(" + (joinWithSep ((toRGB color) ++ extra) ", ") + ")";

  /* Type:
       rgbColor :: String -> String
     
     Example:
       rgbColor "FFFFFF"
       => "rgb(255, 255, 255)"
  */
  rgbColor = color: "rgb" + _rgbColor color [];

  /* Type:
       rgbaColor :: String -> Int -> String
     
     Example:
       rgbaColor "FFFFFF" 42
       => "rgba(255, 255, 255, 0.42)"
  */
  rgbaColor = color: _opacity: let
    opacityStr = fixedWidthString 3 "0" (toString _opacity);
    opacity = substring 0 1 opacityStr + "." + substring 1 2 opacityStr;
  in "rgba" + _rgbColor color [opacity];

  /* ‹colors› defines a color palette according to the Tailwind colors:
     https://tailwindcss.com/docs/customizing-colors#color-palette-reference

     Each individual color has 10 variants, for example to access the variant
     ‹700› of color ‹red› following notation is used: ‹colors.red._700›

     The ‹_› in front of the variant is there because numbers cannot be
     used as keys.
  */
  colors = let
    scaleDef = [ 50 100 200 300 400 500 600 700 800 900 ];
    scale = s: listToAttrs (zipListsWith (variant: color: nameValuePair "_${toString variant}" color) scaleDef s);
  in rec {
    # Default palette
    blueGray = scale [ "F8FAFC" "F1F5F9" "E2E8F0" "CBD5E1" "94A3B8" "64748B" "475569" "334155" "1E293B" "0F172A" ];
    coolGray = scale [ "F9FAFB" "F3F4F6" "E5E7EB" "D1D5DB" "9CA3AF" "6B7280" "4B5563" "374151" "1F2937" "111827" ];
    gray     = scale [ "FAFAFA" "F4F4F5" "E4E4E7" "D4D4D8" "A1A1AA" "71717A" "52525B" "3F3F46" "27272A" "18181B" ];
    trueGray = scale [ "FAFAFA" "F5F5F5" "E5E5E5" "D4D4D4" "A3A3A3" "737373" "525252" "404040" "262626" "171717" ];
    warmGray = scale [ "FAFAF9" "F5F5F4" "E7E5E4" "D6D3D1" "A8A29E" "78716C" "57534E" "44403C" "292524" "1C1917" ];
    red      = scale [ "FEF2F2" "FEE2E2" "FECACA" "FCA5A5" "F87171" "EF4444" "DC2626" "B91C1C" "991B1B" "7F1D1D" ];
    orange   = scale [ "FFF7ED" "FFEDD5" "FFEDD5" "FDBA74" "FB923C" "F97316" "EA580C" "C2410C" "9A3412" "7C2D12" ];
    amber    = scale [ "FFFBEB" "FEF3C7" "FDE68A" "FCD34D" "FBBF24" "F59E0B" "D97706" "B45309" "92400E" "78350F" ];
    yellow   = scale [ "FEFCE8" "FEF9C3" "FEF08A" "FDE047" "FACC15" "EAB308" "CA8A04" "A16207" "854D0E" "713F12" ];
    lime     = scale [ "F7FEE7" "ECFCCB" "D9F99D" "BEF264" "A3E635" "84CC16" "65A30D" "4D7C0F" "3F6212" "365314" ];
    green    = scale [ "F0FDF4" "DCFCE7" "BBF7D0" "86EFAC" "4ADE80" "22C55E" "16A34A" "15803D" "166534" "14532D" ];
    emerald  = scale [ "ECFDF5" "D1FAE5" "A7F3D0" "6EE7B7" "34D399" "10B981" "059669" "047857" "065F46" "064E3B" ];
    teal     = scale [ "F0FDFA" "CCFBF1" "99F6E4" "5EEAD4" "2DD4BF" "14B8A6" "0D9488" "0F766E" "115E59" "134E4A" ];
    cyan     = scale [ "ECFEFF" "CFFAFE" "A5F3FC" "67E8F9" "22D3EE" "06B6D4" "0891B2" "0E7490" "155E75" "164E63" ];
    sky      = scale [ "F0F9FF" "E0F2FE" "BAE6FD" "7DD3FC" "38BDF8" "0EA5E9" "0284C7" "0369A1" "075985" "0C4A6E" ];
    blue     = scale [ "EFF6FF" "DBEAFE" "BFDBFE" "93C5FD" "60A5FA" "3B82F6" "2563EB" "1D4ED8" "1E40AF" "1E3A8A" ];
    indigo   = scale [ "EEF2FF" "E0E7FF" "C7D2FE" "A5B4FC" "818CF8" "6366F1" "4F46E5" "4338CA" "3730A3" "312E81" ];
    violet   = scale [ "F5F3FF" "EDE9FE" "DDD6FE" "C4B5FD" "A78BFA" "8B5CF6" "7C3AED" "6D28D9" "5B21B6" "4C1D95" ];
    purple   = scale [ "FAF5FF" "F3E8FF" "E9D5FF" "D8B4FE" "C084FC" "A855F7" "9333EA" "7E22CE" "6B21A8" "581C87" ];
    fuchsia  = scale [ "FDF4FF" "FAE8FF" "F5D0FE" "F0ABFC" "E879F9" "D946EF" "C026D3" "A21CAF" "86198F" "701A75" ];
    pink     = scale [ "FDF2F8" "FCE7F3" "FBCFE8" "F9A8D4" "F472B6" "EC4899" "DB2777" "BE185D" "9D174D" "831843" ];
    rose     = scale [ "FFF1F2" "FFE4E6" "FECDD3" "FDA4AF" "FB7185" "F43F5E" "E11D48" "BE123C" "9F1239" "881337" ];
  };
}
