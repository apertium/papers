BEGIN { 
    firsts = 0; seconds = 0; thirds = 0; fourths = 0;
    no_results = 0; no_corrects = 0; in_dict = 0;
    totals += 1;
    FS = "\t";
}
/^Hunspell/ { 
    printf("ERROR! please remove Hunspell gunk from results\n");
    exit(1);
}
$1 ~ /^[[:space:]]*$/ { /* empty line??? */ }
/^[*+-]/ { 
    in_dict += 1;
    totals += 1;
}
/^\&/ { split(gensub(/^[^:]*: */, "", "", $1), results, /, */);
   
    if (results[1] == $3)
    {
        firsts += 1;
    }
    else if ( (length(results) > 1) && (results[2] == $3) )
    {
        seconds += 1;
    }
    else if ( (length(results) > 2) && (results[3] == $3) )
    {
        thirds += 1;
    }
    else if ( (length(results) > 3) && (results[4] == $3) )
    {
        fourths += 1;
    }
    else
    {
        found = 0;
        for (i = 4; i < length(results); i++)
        {
            if (results[i] == $3)
            {
                found = 1;
            }
        }
        if (found == 0)
        {
            no_corrects += 1;
        }
        else
        {
            rests += 1;
        }
    }
    totals += 1;
}
/^#/ { 
    no_results += 1;
    totals += 1;
}
/^[^*+&#H\t	-]$/ {
    printf("Unrecognised hunspell line:\n%s\n", $1);
    exit(1);
}
END {
    printf("%s\t%s\t%s\t%s\t%s\n", "All", "In LM", "LM+EM", "0s", "Impossible");
    printf("%d\t%d\t?\t%d\t?\n",
           totals, in_dict, no_results);
    totals -= in_dict;
    printf("%s\t%s\t%s\t%s\t%s\t%s\t%s\n",
           "All", "1st", "2nd", "3rd", "4rd", "rest", "wrongs");
    printf("%d\t%d\t%d\t%d\t%d\t%d\t%d\n",
           totals,
           firsts, seconds, thirds, fourths, rests, no_corrects);
}
