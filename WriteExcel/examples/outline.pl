#!/usr/bin/perl -w

###############################################################################
#
# Example of how use Spreadsheet::WriteExcel to generate Excel outlines and
# grouping.
#
#
# reverse('�'), April 2003, John McNamara, jmcnamara@cpan.org
#



use strict;
use Spreadsheet::WriteExcel;

# Create a new workbook and add some worksheets
my $workbook   = Spreadsheet::WriteExcel->new('outline.xls');
my $worksheet1 = $workbook->add_worksheet('Outlined Rows');
my $worksheet2 = $workbook->add_worksheet('Collapsed Rows');
my $worksheet3 = $workbook->add_worksheet('Outline Columns');
my $worksheet4 = $workbook->add_worksheet('Outline levels');

# Add a general format
my $bold = $workbook->add_format(bold => 1);



###############################################################################
#
# Example 1: Create a worksheet with outlined rows. It also includes SUBTOTAL()
# functions so that it looks like the type of automatic outlines that are
# generated when you use the Excel Data->SubTotals menu item.
#


# For outlines the important parameters are $hidden and $level. Rows with the
# same $level are grouped together. The group will be collapsed if $hidden is
# non-zero. $height and $XF are assigned default values if they are undef.
#
# The syntax is: set_row($row, $height, $XF, $hidden, $level)
#
$worksheet1->set_row(1,  undef, undef, 0, 2);
$worksheet1->set_row(2,  undef, undef, 0, 2);
$worksheet1->set_row(3,  undef, undef, 0, 2);
$worksheet1->set_row(4,  undef, undef, 0, 2);
$worksheet1->set_row(5,  undef, undef, 0, 1);

$worksheet1->set_row(6,  undef, undef, 0, 2);
$worksheet1->set_row(7,  undef, undef, 0, 2);
$worksheet1->set_row(8,  undef, undef, 0, 2);
$worksheet1->set_row(9,  undef, undef, 0, 2);
$worksheet1->set_row(10, undef, undef, 0, 1);


# Add a column format for clarity
$worksheet1->set_column('A:A', 20);

# Add the data, labels and formulas
$worksheet1->write('A1',  'Region', $bold);
$worksheet1->write('A2',  'North');
$worksheet1->write('A3',  'North');
$worksheet1->write('A4',  'North');
$worksheet1->write('A5',  'North');
$worksheet1->write('A6',  'North Total', $bold);

$worksheet1->write('B1',  'Sales',  $bold);
$worksheet1->write('B2',  1000);
$worksheet1->write('B3',  1200);
$worksheet1->write('B4',  900);
$worksheet1->write('B5',  1200);
$worksheet1->write('B6',  '=SUBTOTAL(9,B2:B5)', $bold);

$worksheet1->write('A7',  'South');
$worksheet1->write('A8',  'South');
$worksheet1->write('A9',  'South');
$worksheet1->write('A10', 'South');
$worksheet1->write('A11', 'South Total', $bold);

$worksheet1->write('B7',  400);
$worksheet1->write('B8',  600);
$worksheet1->write('B9',  500);
$worksheet1->write('B10', 600);
$worksheet1->write('B11', '=SUBTOTAL(9,B7:B10)', $bold);

$worksheet1->write('A12', 'Grand Total', $bold);
$worksheet1->write('B12', '=SUBTOTAL(9,B2:B10)', $bold);


###############################################################################
#
# Example 2: Create a worksheet with outlined rows. This is the same as the
# previous example except that the rows are collapsed.
#


# The group will be collapsed if $hidden is non-zero.
# The syntax is: set_row($row, $height, $XF, $hidden, $level)
#
$worksheet2->set_row(1,  undef, undef, 1, 2);
$worksheet2->set_row(2,  undef, undef, 1, 2);
$worksheet2->set_row(3,  undef, undef, 1, 2);
$worksheet2->set_row(4,  undef, undef, 1, 2);
$worksheet2->set_row(5,  undef, undef, 1, 1);

$worksheet2->set_row(6,  undef, undef, 1, 2);
$worksheet2->set_row(7,  undef, undef, 1, 2);
$worksheet2->set_row(8,  undef, undef, 1, 2);
$worksheet2->set_row(9,  undef, undef, 1, 2);
$worksheet2->set_row(10, undef, undef, 1, 1);


# Add a column format for clarity
$worksheet2->set_column('A:A', 20);

# Add the data, labels and formulas
$worksheet2->write('A1',  'Region', $bold);
$worksheet2->write('A2',  'North');
$worksheet2->write('A3',  'North');
$worksheet2->write('A4',  'North');
$worksheet2->write('A5',  'North');
$worksheet2->write('A6',  'North Total', $bold);

$worksheet2->write('B1',  'Sales',  $bold);
$worksheet2->write('B2',  1000);
$worksheet2->write('B3',  1200);
$worksheet2->write('B4',  900);
$worksheet2->write('B5',  1200);
$worksheet2->write('B6',  '=SUBTOTAL(9,B2:B5)', $bold);

$worksheet2->write('A7',  'South');
$worksheet2->write('A8',  'South');
$worksheet2->write('A9',  'South');
$worksheet2->write('A10', 'South');
$worksheet2->write('A11', 'South Total', $bold);

$worksheet2->write('B7',  400);
$worksheet2->write('B8',  600);
$worksheet2->write('B9',  500);
$worksheet2->write('B10', 600);
$worksheet2->write('B11', '=SUBTOTAL(9,B7:B10)', $bold);

$worksheet2->write('A12', 'Grand Total', $bold);
$worksheet2->write('B12', '=SUBTOTAL(9,B2:B10)', $bold);



###############################################################################
#
# Example 3: Create a worksheet with outlined columns.
#
my $data = [
            ['Month', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',' Total'],
            ['North', 50,    20,    15,    25,    65,    80,    ,'=SUM(B2:G2)'],
            ['South', 10,    20,    30,    50,    50,    50,    ,'=SUM(B3:G3)'],
            ['East',  45,    75,    50,    15,    75,    100,   ,'=SUM(B4:G4)'],
            ['West',  15,    15,    55,    35,    20,    50,    ,'=SUM(B5:G6)'],
           ];

# Add bold format to the first row
$worksheet3->set_row(0, undef, $bold);

# The syntax is: set_column($first, $last, $height, $XF, $hidden, $level)
$worksheet3->set_column('A:A', 10, $bold      );
$worksheet3->set_column('B:G', 5,  undef, 0, 1);
$worksheet3->set_column('H:H', 10);

# Write the data and a formula
$worksheet3->write_col('A1', $data);
$worksheet3->write('H6', '=SUM(H2:H5)', $bold);



###############################################################################
#
# Example 4: Show all possible outline levels.
#
my $levels = ["Level 1", "Level 2", "Level 3", "Level 4",
              "Level 5", "Level 6", "Level 7", "Level 6",
              "Level 5", "Level 4", "Level 3", "Level 2", "Level 1"];


$worksheet4->write_col('A1', $levels);

$worksheet4->set_row(0,  undef, undef, undef, 1);
$worksheet4->set_row(1,  undef, undef, undef, 2);
$worksheet4->set_row(2,  undef, undef, undef, 3);
$worksheet4->set_row(3,  undef, undef, undef, 4);
$worksheet4->set_row(4,  undef, undef, undef, 5);
$worksheet4->set_row(5,  undef, undef, undef, 6);
$worksheet4->set_row(6,  undef, undef, undef, 7);
$worksheet4->set_row(7,  undef, undef, undef, 6);
$worksheet4->set_row(8,  undef, undef, undef, 5);
$worksheet4->set_row(9,  undef, undef, undef, 4);
$worksheet4->set_row(10, undef, undef, undef, 3);
$worksheet4->set_row(11, undef, undef, undef, 2);
$worksheet4->set_row(12, undef, undef, undef, 1);



__END__
