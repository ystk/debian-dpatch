#!/usr/bin/nawk -f
# shpp.awk -- Simple preprocessor for shell scripts
#
#  Copyright (C) 2003  Miles Bader <miles@gnu.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# Written by Miles Bader <miles@gnu.org>

BEGIN {
  if ("srcdir" in ENVIRON)
    srcdir = ENVIRON["srcdir"]
  else
    srcdir = "."
}

function include_file(file, escape_single_quotes  ,hdr_comment_skip_state)
{
  file = srcdir "/" file
  hdr_comment_skip_state = 2
  while ((getline <file) > 0) {
    if (hdr_comment_skip_state) {
      if ($0 ~ /^(#:|[^#]|$)/)
	hdr_comment_skip_state = 0
      else {
	if ($0 ~ /^# *$/)
	  hdr_comment_skip_state = 1
	if (hdr_comment_skip_state == 1)
	  continue
      }
    }
    process_line(escape_single_quotes)
  }
  close (file)
}

# Process the input line in $0; destroys $0!
function process_line(escape_single_quotes,  file,val,var)
{
  if ($1 == "#:include") {
    file = $2
    print "# (---- beginning of " file " ----)"
    include_file(file, escape_single_quotes)
    print "# (---- end of " file " ----)"
  } else if ($1 == "#:var-include") {
    var = $2
    file = $3
    print "# (---- " var " defined from " file " ----)"
    printf ("%s='", var)
    include_file(file, 1)
    print "'"
    print "# (---- end of " var " defined from " file " ----)"
  } else if ($1 == "#:local-var" || $1 == "#:export-var") {
    if ($2 in ENVIRON) {
      val = ENVIRON[$2]
      # Escape any single quotes
      gsub (/'/, "'\\''", val)
      
      if ($1 == "#:export-var")
	printf ("%s='%s'; export %s\n", $2, val, $2)
      else
	printf ("%s='%s'\n", $2, val)
    }
  } else {
    if (escape_single_quotes)
      gsub (/'/, "'\\''")
    # Note we strip arch-tag: lines from the destination
    if ($0 !~ /^#* *arch-tag:/)
      print
  }
}

{ process_line(0) }

# arch-tag: 7f61e98c-a589-4905-a0a1-338a68eb133d
