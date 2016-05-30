//
//  Tutorial2Example.m
//  libxlsxwriter-ObjC
//
//  Created by Ludovico Rossi on 11/11/15.
//  Copyright © 2015 Ludovico Rossi. All rights reserved.
//

#if USE_FRAMEWORKS
	@import xlsxwriter;
#else
	#import <libxlsxwriter/xlsxwriter.h>
#endif

#import "Tutorial2Example.h"

@implementation Tutorial2Example

- (NSString *)title {
    return @"Tutorial 2";
}

- (NSString *)subtitle {
    return @"Tutorial 2 from the documentation";
}

- (NSString *)outputFileName {
    return @"tutorial02";
}

- (void)run {
    /*
     * A simple program to write some data to an Excel file using the
     * libxlsxwriter library.
     *
     * This program is shown, with explanations, in Tutorial 2 of the
     * libxlsxwriter documentation.
     *
     * Copyright 2014-2015, John McNamara, jmcnamara@cpan.org
     *
     */
    
    /* Some data we want to write to the worksheet. */
    struct expense {
        char item[32];
        int  cost;
    };
    struct expense expenses[] = {
        {"Rent", 1000},
        {"Gas",   100},
        {"Food",  300},
        {"Gym",    50},
    };
    
    /* Create a workbook and add a worksheet. */
    lxw_workbook  *workbook  = new_workbook([self.outputFilePath cStringUsingEncoding:NSUTF8StringEncoding]);
    lxw_worksheet *worksheet = workbook_add_worksheet(workbook, NULL);
    int row = 0;
    int col = 0;
    int i;
    
    /* Add a bold format to use to highlight cells. */
    lxw_format *bold = workbook_add_format(workbook);
    format_set_bold(bold);
    
    /* Add a number format for cells with money. */
    lxw_format *money = workbook_add_format(workbook);
    format_set_num_format(money, "$#,##0");
    
    /* Write some data header. */
    worksheet_write_string(worksheet, row, col,     "Item", bold);
    worksheet_write_string(worksheet, row, col + 1, "Cost", bold);
    
    /* Iterate over the data and write it out element by element. */
    for (i = 0; i < 4; i++) {
        /* Write from the first cell below the headers. */
        row = i + 1;
        worksheet_write_string(worksheet, row, col,     expenses[i].item, NULL);
        worksheet_write_number(worksheet, row, col + 1, expenses[i].cost, money);
    }
    
    /* Write a total using a formula. */
    worksheet_write_string (worksheet, row + 1, col,     "Total",       bold);
    worksheet_write_formula(worksheet, row + 1, col + 1, "=SUM(B2:B5)", money);
    
    /* Save the workbook and free any allocated memory. */
    workbook_close(workbook);
}

@end
