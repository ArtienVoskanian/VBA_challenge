Attribute VB_Name = "Module1"
Sub Stock_Data_Sorter():

'Enable it to run on every worksheet (that is, every year) at once.

For Each ws In ActiveWorkbook.Worksheets


    Dim WorksheetName As String
    Dim ticker As String
    Dim counter As Integer
    Dim last_row As LongLong
    Dim open_price As Double
    Dim closing_price As Double
    Dim yearly_change As Double
    Dim yc_counter As Integer
    Dim perecent_change As Double
    Dim volume As Double
    Dim greatest_increase As Double
    Dim greatest_decrease As Double
    Dim greatest_volume As Double
    Dim increase_ticker As String
    Dim decrease_ticker As String
    Dim volume_ticker As String
    
    WorksheetName = ws.Name
    counter = 2
    yc_counter = 2
    greatest_increase = 0
    greatest_decrease = 0
    greatest_volume = 0
    volume = 0
    last_row = ws.Cells(Rows.Count, 1).End(xlUp).Row
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Yearly Change"
    ws.Cells(1, 11).Value = "Percent Change"
    ws.Cells(1, 12).Value = "Total Stock Volume"
    ws.Cells(2, 14).Value = "Greatest % Increase"
    ws.Cells(3, 14).Value = "Greatest % Decrease"
    ws.Cells(4, 14).Value = "Greatest Total Volume"
    ws.Cells(1, 15).Value = "Ticker"
    ws.Cells(1, 16).Value = "Value"
    
    
'Create a script that loops through all the stocks for one year and outputs the following information:
'The ticker symbol
'The total stock volume of the stock.

        For i = 2 To last_row
        
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
            ticker = ws.Cells(i, 1).Value
            ws.Range("I" & counter).Value = ticker
            counter = counter + 1
            volume = volume + ws.Cells(i, 7).Value
            ws.Range("L" & (counter - 1)).Value = volume
            volume = 0
            
            ElseIf ws.Cells(i, 1).Value = ws.Cells(i + 1, 1).Value Then
            volume = volume + ws.Cells(i, 7).Value
            
            Else:
            
            End If
            
            
            
        Next i
        
'Yearly change from the opening price at the beginning of a given year to the closing price at the end of that year.
'The percentage change from the opening price at the beginning of a given year to the closing price at the end of that year.

        For i = 2 To last_row
            
            If ws.Cells(i, 1).Value = ws.Cells(i + 1, 1).Value And ws.Cells(i, 1).Value <> ws.Cells(i - 1, 1).Value Then
            open_price = ws.Cells(i, 3).Value
            
            ElseIf ws.Cells(i, 1).Value = ws.Cells(i - 1, 1).Value And ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value Then
            closing_price = ws.Cells(i, 6).Value
            yearly_change = closing_price - open_price
            ws.Range("J" & yc_counter).Value = yearly_change
            percent_change = (((closing_price - open_price) / open_price))
            ws.Range("K" & yc_counter).Value = Format(percent_change, "Percent")
            yc_counter = yc_counter + 1
                        
            End If
        
        Next i
        
 
        
'Conditional Formatting
        
        For i = 2 To yc_counter - 1
        
            If ws.Cells(i, 10).Value > 0 Then
            ws.Cells(i, 10).Interior.ColorIndex = 4
            
            ElseIf ws.Cells(i, 10).Value < 0 Then
            ws.Cells(i, 10).Interior.ColorIndex = 3
            
            ElseIf ws.Cells(i, 10).Value = 0 Then
            ws.Cells(i, 10).Interior.ColorIndex = 6
                        
            End If
            
        Next i
        
'Greatest % increase, Greatest % decrease

        For i = 2 To yc_counter - 1
        
            If ws.Cells(i, 11).Value > 0 And ws.Cells(i, 11).Value > greatest_increase Then
            greatest_increase = ws.Cells(i, 11).Value
            ws.Cells(2, 16).Value = greatest_increase
            ws.Cells(2, 16).Value = Format(greatest_increase, "Percent")
            increase_ticker = ws.Cells(i, 9).Value
            ws.Cells(2, 15).Value = increase_ticker
                 
            ElseIf ws.Cells(i, 11).Value < 0 And ws.Cells(i, 11).Value < greatest_decrease Then
            greatest_decrease = ws.Cells(i, 11).Value
            ws.Cells(3, 16).Value = greatest_decrease
            ws.Cells(3, 16) = Format(greatest_decrease, "Percent")
            decrease_ticker = ws.Cells(i, 9).Value
            ws.Cells(3, 15).Value = decrease_ticker
            End If
            
        Next i
        
'Greatest total volume"

        For i = 2 To yc_counter - 1
        
            If ws.Cells(i, 12).Value > ws.Cells(i + 1, 12).Value And ws.Cells(i, 12).Value > greatest_volume Then
            volume_ticker = ws.Cells(i, 9).Value
            ws.Cells(4, 15).Value = volume_ticker
            greatest_volume = ws.Cells(i, 12).Value
            ws.Cells(4, 16).Value = greatest_volume
            
            ElseIf ws.Cells(i, 12).Value < ws.Cells(i + 1, 12).Value And ws.Cells(i + 1, 12).Value > greatest_volume Then
            volume_ticker = ws.Cells(i + 1, 9).Value
            ws.Cells(4, 15).Value = volume_ticker
            greatest_volume = ws.Cells(i + 1, 12).Value
            ws.Cells(4, 16).Value = greatest_volume
            
            End If
            
        Next i
        
'Autofit the data for readability

ws.Columns("I:P").AutoFit

Next ws

End Sub
