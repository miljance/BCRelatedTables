//modifying one third of all records with Job No.
report 50101 JLEGenerateDemoData1
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    trigger OnPreReport()
    var
        Job: Record Job;
        JobLedgerEntry: Record "Job Ledger Entry";
    begin
        Job.FindFirst();
        JobLedgerEntry.SetRange("Job No.", Job."No.");
        JobLedgerEntry.ModifyAll("Ext field 1", Job."No.");
    end;
}