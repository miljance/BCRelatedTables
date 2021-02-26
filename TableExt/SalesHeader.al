tableextension 50100 SalesHeader extends "Sales Header"
{
    fields
    {
        field(50100; "Job No."; Code[20])
        {
            TableRelation = Job;
        }
    }
}
