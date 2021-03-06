Sub stock_analysis()

Dim ws As Worksheet

For Each ws In Worksheets

    Dim outputrow As Double
    outputrow = 2
    Dim year_open As Double
    Dim year_close As Double
    Dim stock_total As Double
    
    ws.Cells(1, 9).Value = "Ticker"
    ws.Cells(1, 10).Value = "Yearly Change"
    ws.Cells(1, 11).Value = "Percent Change"
    ws.Cells(1, 12).Value = "Total Stock Volume"
    
    ws.Columns("J").NumberFormat = "$0.00"
    ws.Columns("K").NumberFormat = "0.00%"
    ws.Columns("K").HorizontalAlignment = xlRight
    
    For Row = 2 To ws.Range("A1").End(xlDown).Row
        
        stock_total = stock_total + ws.Cells(Row, 7).Value
            
        If ws.Cells(Row, 1).Value <> ws.Cells(Row - 1, 1).Value Then
            
            year_open = ws.Cells(Row, 3).Value
                
        ElseIf ws.Cells(Row, 1).Value = ws.Cells(Row - 1, 1).Value Then
        
            year_open = year_open
                       
        End If
            
        If ws.Cells(Row, 1).Value <> ws.Cells(Row + 1, 1).Value Then
            
            year_close = ws.Cells(Row, 6).Value
            
            ws.Cells(outputrow, 9).Value = ws.Cells(Row, 1).Value
            ws.Cells(outputrow, 10).Value = year_close - year_open
            
            If year_open = 0 Then
            
                ws.Cells(outputrow, 11).Value = "NaN"
            
            Else
            
                ws.Cells(outputrow, 11).Value = ws.Cells(outputrow, 10) / year_open
            
            End If
            
            ws.Cells(outputrow, 12).Value = stock_total
            
            outputrow = outputrow + 1
            
            stock_total = 0
            
        End If
    
    Next Row
    
    For Row = 2 To ws.Range("A1").End(xlDown).Row
    
        If ws.Cells(Row, 10).Value > 0 Then
        
            ws.Cells(Row, 10).Interior.Color = vbGreen
            
        ElseIf ws.Cells(Row, 10).Value < 0 Then
            
            ws.Cells(Row, 10).Interior.Color = vbRed
        
        End If
    
    Next Row
    
    ws.Cells(2, 15).Value = "Greatest % Increase"
    ws.Cells(3, 15).Value = "Greatest % Decrease"
    ws.Cells(4, 15).Value = "Greatest Total Volume"
    ws.Cells(1, 16).Value = "Ticker"
    ws.Cells(1, 17).Value = "Value"
    
    ws.Range("Q2, Q3").NumberFormat = "0.00%"
    
    Dim greatest_increase, greatest_decrease, greatest_total_volume As Double
    
    greatest_increase = Application.WorksheetFunction.Max(ws.Range("K:K"))
    ws.Cells(2, 17) = greatest_increase
    
    greatest_decrease = Application.WorksheetFunction.Min(ws.Range("K:K"))
    ws.Cells(3, 17) = greatest_decrease
    
    greatest_total_volume = Application.WorksheetFunction.Max(ws.Range("L:L"))
    ws.Cells(4, 17) = greatest_total_volume
    
    For Row = 2 To ws.Range("I1").End(xlDown).Row
        
        If ws.Cells(Row, 11) = greatest_increase Then
        
            ws.Cells(2, 16).Value = ws.Cells(Row, 9).Value
        
        End If
        
        If ws.Cells(Row, 11) = greatest_decrease Then
        
            ws.Cells(3, 16).Value = ws.Cells(Row, 9).Value
        
        End If
        
        If ws.Cells(Row, 12) = greatest_total_volume Then
        
            ws.Cells(4, 16).Value = ws.Cells(Row, 9).Value
        
        End If
        
    Next Row
    
ws.Cells.EntireColumn.AutoFit
    
Next ws

End Sub
