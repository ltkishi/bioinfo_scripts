#!/usr/bin/perl
# Philip Shuman philip at shuman dot org
# http://www.shuman.org/scripts/
# $Id: album.pl,v 1.20 2005/04/04 03:06:51 pshuman Exp $
#
# album.pl 
$version = 'v0.3.7';
# photo album web page generator and photo resizer
#
# requires ImageMagick's `mogrify` utility,
# Image::Size from http://www.blackperl.com/Image::Size/
# and Getopt::Std.
#
#  To install the perl modules, try running:
#  # perl -MCPAN -e shell
#  cpan> install Image::Size
#  cpan> install Getopt::Std
#  cpan> quit
#
# Usage:
#   cd into the directory with your .jpg files.
#   Run album.pl
#   Give it the -g 640x480,800x600,1024x768 to create different
#   scaled images. (without -g will only create thumbnails and html)
#   Be sure to list your resolutions in ascending order.
#
#   By default, if you run the album.pl again, it will not regenerate the
#   scaled images if they exist. Give the -f option to force recreation.
#
#   -e will excluding original images from the html. This is useful if your
#   camera makes images large than what you wnat on your web page. You need
#   to remove the originals yourself.
#
# Change thess defauls to your email, name, etc. Any of these values
# specified in any of the .albumrc files will take priority.
$comment      = "Organized with album.pl from LBMP"; # EXIF comment
$name         = "LBMP ALBUM";
$mogrify_path = 'mogrify'; #if mogrify isn't in your path, specify the full path
$thm_size     = "128x96";
$timer        = "6";       # number of seconds per image in slideshow
$col_width    = '6';       # number of thumbnail columns
$year         = `date '+%Y'`; # This year for copyright date
$footer       = "Copyright &copy; $year $name All rights reserved. Do not use without permission.";

$userHome = $ENV{'HOME'};
print "Checking for $userHome/.albumrc ... ";
eval{require "$userHome/.albumrc"};  # load user's Global settings
if($@)
{
   print "not found\n";
}
else
{
   print "found\n";
}

print "Checking for a local .albumrc ... ";
eval{require ".albumrc"}; # load album specific settings (overrides above)
if($@)
{
   print "not found\n";
}
else
{
   print "found\n";
}

use Image::Size;
use Getopt::Std;

sub gen_files
{
   my ($prev_html, $current_html, $current_img, $next_html, $link, $advance,
       $minus_html, $plus_html, $next_img) = @_;
   open(FILE, "> $current_html") or die "Can't open: $current_html\n";
   print FILE "<html><head><title>[ $current_img ]</title>\n";
   print FILE "<!-- Created with Phil's album.pl $version http://www.shuman.org/scripts/album.html -->\n";

   my $state;
   if ($advance eq "1")
   {
      print FILE "  <META HTTP-EQUIV=Refresh ";
      print FILE "CONTENT=$timer;";
      print FILE "URL=$next_html>\n";
      print FILE "  <META HTTP-EQUIV=\"Pragma\" CONTENT=\"no-cache\">\n";
      $state = "||";
   }
   else
   {
      $state = ">";
      $prev_html =~ s/\.html/_pause.html/;
      $next_html =~ s/\.html/_pause.html/;
      $minus_html =~ s/\.html/_pause.html/;
      $plus_html =~ s/\.html/_pause.html/;
   }
   print FILE "  <script language=\"JavaScript\">\n";
   print FILE "  <!--\n";
   print FILE "    image1 = new Image();\n";
   print FILE "    image1.src = \"$next_img\";\n  //-->\n";
   print FILE "  </script>\n";

   print FILE "</head>\n<body><center>\n";
   print FILE "  <table border=0>\n";
   print FILE "     <tr>\n";
   print FILE "        <td align=left width=25%><a href=index.html>Index</a></td>\n";
   print FILE "        <td align=center width=50%>\n";
   print FILE "           <a href=$prev_html><<</a>\&nbsp\;\&nbsp\;\n";
   print FILE "           <a href=$link>$state</a>\&nbsp\;\&nbsp\;\n";
   print FILE "           <a href=$next_html>>></a></td>\n";
   print FILE "        <td align=right width=25%>";

   if ($minus_html ne "" || $plus_html ne "")
   {
      print FILE "Zoom: ";
   }

   if ($minus_html ne "")
   {
      print FILE "(<a href=$minus_html>-</a>) ";
   }
   if ($plus_html ne "")
   {
      print FILE "(<a href=$plus_html>+</a>)\n";
   }
   print FILE "        </td>\n";
   print FILE "     </tr><tr>\n";

   print FILE "        <td align=center colspan=3>\n";
   print FILE "           <img src=$current_img><br><br>\n";
   print FILE "           $current_img\n";
   print FILE "        </td>\n";
   print FILE "     </tr>\n";
   print FILE "     <tr align=center colspan=3>\n";
   print FILE "        <td colspan=3><font size=-1>$footer\n";
   print FILE "         </font></td>\n";
   print FILE "     </tr>\n";
   print FILE "     </table>\n";
   print FILE "</center></body></html>\n";
   close FILE;
}


if (getopts("fg:e")) {
}
else {
   print "album.pl $version usage:\n";
   print " -g <image sizes>  specify image sizes: 640x480,800x600\n";
   print " -f                force regeneration of scaled images\n";
   print " -e                exclude original images from the html\n";
   exit -1;
}
if (!$opt_g) {
   @geos = ('640x480', '1024x768');
   print "no -g, we will not scale images, only create thumbnails and html\n";
}
else {
   @geos = split(',', $opt_g);
}

if ($opt_e) {
   print "-e, excluding original images from the html\n";
}

@files = `/bin/ls -1 *.jpg *.JPG | grep -vi _thm.jpg | grep -vi _640x480.jpg |grep -vi _800x600.jpg | grep -vi _1024x768.jpg | grep -vi _320x200.jpg`;
$first_file = $files[0];
$first_file =~ s/\.jpg/.html/i;

$last_index = $#files;
$i=0;

`echo "<!-- Created with Phil's album.pl $version http://www.shuman.org/scripts/album.html -->" > index.html`;
`echo "<table><tr>" >> index.html`;
$width_counter = 0;

while ($i <= $last_index) {   # one pass per original image
   my $file = $files[$i];
   chomp($file);

   ($x, $y) = imgsize("$file");
   $orgsize = "$x" . "x$y";
   print "(" . ($i+1) . " of " . ($last_index+1) . ")";
   print " $file ($x" . "x$y)\n";

   $thmnail = $file;
   $thmnail =~ s/\.jpg/_thm.jpg/i;
   if (-f $thmnail && !$opt_f)
   {
      print "   Skipping $thmnail\n";
   }
   else
   {
      print "   Creating $thmnail\n";
      `cp $file $thmnail`;
      `chmod u+w $thmnail`;
      `$mogrify_path -geometry $thm_size -quality 55 $thmnail`;
   }

   ($thm_x, $thm_y) = imgsize("$thmnail");
   $firstsize = $file;
   $firstsize =~ s/\.jpg/_$geos[0]_pause.html/i;
   `echo "   <td valign=top><a href=$firstsize>" >> index.html`;
   `echo "      <img width=$thm_x height=$thm_y src=$thmnail border=0></a><br>" >> index.html`;

   $last_res_index = $#geos;
   $i_res=0;
   while ($i_res <= $last_res_index) { #one pass per image size per image
      my $res = $geos[$i_res];
      my $tmp = $file;
      $tmp =~ s/\.jpg/_$res.jpg/i;
      if (-f $tmp && !$opt_f)
      {
         print "   Skipping $tmp\n";
      }
      else
      {
         print "   Creating $tmp\n";
         `cp $file $tmp`;
         `chmod u+w $tmp`;
         `$mogrify_path -comment "$comment" -geometry $res -quality 70 $tmp `;
      }
      #`echo "      <a href=$tmp>$res</a><br>" >> index.html`;

      my $prev_name;
      my $next_name;

      if ($i > 0)
      {
         $prev_name = $files[$i-1];
      }
      else
      {
         $prev_name = $files[$last_index];
      }
      chomp($prev_name);

      if ($i < $last_index)
      {
         $next_name = $files[$i+1];
      }
      else
      {
         $next_name = $files[0];
      }
      chomp($next_name);

      $next_img = $next_name;
      $next_img =~ s/\.jpg/_$res.jpg/i;
      $next_name =~ s/\.jpg/_$res.html/i;
      $prev_name =~ s/\.jpg/_$res.html/i;
      my $htmlfile = $tmp;
      $htmlfile =~ s/\.jpg/.html/i;
      my $htmlfile_pause = $htmlfile;
      $htmlfile_pause =~ s/\.html/_pause.html/i;

      my $minus = $file;
      if ($i_res > 0)
      {
         $minus =~ s/\.jpg/_$geos[$i_res-1].html/i;
      }
      else
      {
         $minus = "";
      }

      my $plus = $file;
      if ($i_res == $last_res_index)
      {
         $plus =~ s/\.jpg/.html/i;
      }
      else
      {
         $plus =~ s/\.jpg/_$geos[$i_res+1].html/i;
      }

      if ($i_res == $last_res_index && $opt_e)
      {
         $plus = "";
      }

      gen_files($prev_name, $htmlfile, $tmp, $next_name, $htmlfile_pause, 1,
         $minus, $plus, $next_img);
      gen_files($prev_name, $htmlfile_pause, $tmp, $next_name, $htmlfile, 0,
         $minus, $plus, $next_img);

      `echo "      <a href=$htmlfile_pause>$res</a><br>" >> index.html`;
      ++$i_res;
   }

   #`echo "      <a href=$file>$orgsize</a>" >> index.html`;
   {
      my $tmp = $file;
      my $prev_name;
      my $next_name;

      if ($i > 0)
      {
         $prev_name = $files[$i-1];
      }
      else
      {
         $prev_name = $files[$last_index];
      }
      chomp($prev_name);

      if ($i < $last_index)
      {
         $next_name = $files[$i+1];
      }
      else
      {
         $next_name = $files[0];
      }
      chomp($next_name);

      $next_img = $next_name;
      $next_name =~ s/\.jpg/.html/i;
      $prev_name =~ s/\.jpg/.html/i;
      my $htmlfile = $tmp;
      $htmlfile =~ s/\.jpg/.html/i;
      my $htmlfile_pause = $htmlfile;
      $htmlfile_pause =~ s/\.html/_pause.html/i;

      my $plus = "";
      my $minus = $file;
      if ($i_res > 0)
      {
         $minus =~ s/\.jpg/_$geos[$last_res_index].html/i;
      }
      else
      {
         $minus = "";
      }

      gen_files($prev_name, $htmlfile, $tmp, $next_name, $htmlfile_pause, 1,
         $minus, $plus, $next_img);
      gen_files($prev_name, $htmlfile_pause, $tmp, $next_name, $htmlfile, 0,
         $minus, $plus, $next_img);

      if (!$opt_e)
      {
         `echo "      <a href=$htmlfile_pause>$orgsize</a><br>" >> index.html`;
      }
   }

   `echo "   </td>" >> index.html`;

   $width_counter++;
   if ($width_counter >= $col_width) {
      `echo "</tr><tr>" >> index.html`;
      $width_counter=0;
   }
   
   ++$i;
}
`echo "</tr></table>" >> index.html`;
`echo "<br><font size=-1>$footer</font><br>" >> index.html`;
`echo "<font size=-1>Created with <a href=http://www.shuman.org/scripts/album.html>album.pl</a></font>" >> index.html`;
