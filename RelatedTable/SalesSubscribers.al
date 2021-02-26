codeunit 50100 SalesSubscribers
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    local procedure OnAfterSalesInvHeaderInsert(var SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    var
        RelatedSalesHeader: Record RelatedSalesHeader;
    begin
        RelatedSalesHeader.PostToInvoice(SalesHeader, SalesInvHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnAfterDeleteSalesHeader(var Rec: Record "Sales Header")
    var
        RelatedSalesHeader: Record RelatedSalesHeader;
    begin
        RelatedSalesHeader.Delete(Rec);
    end;
}
