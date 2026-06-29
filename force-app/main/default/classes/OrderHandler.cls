 public with sharing class OrderHandler {
//     Order & Order Items
// An Order has a custom field Total_Items__c.
// Whenever Order Items are added, removed, or their quantity changes, calculate the total quantity of all Order Items
   public static void orderItemCount(
    List<OrderItem> ordItemsNew,
    Map<Id, OrderItem> ordItemsOld
) {

    Set<Id> ordIds = new Set<Id>();

    // Insert / Update
    if (ordItemsOld == null) {

        for (OrderItem oi : ordItemsNew) {
            if (oi.OrderId != null) {
                ordIds.add(oi.OrderId);
            }
        }

    } else {

        // Update / Delete
        for (OrderItem oi : ordItemsOld.values()) {
            if (oi.OrderId != null) {
                ordIds.add(oi.OrderId);
            }
        }

        if (ordItemsNew != null) {
            for (OrderItem oi : ordItemsNew) {
                if (oi.OrderId != null) {
                    ordIds.add(oi.OrderId);
                }
            }
        }
    }

    if (ordIds.isEmpty()) return;

    List<AggregateResult> agr = [
        SELECT OrderId, SUM(Quantity) totalQty
        FROM OrderItem
        WHERE OrderId IN :ordIds
        GROUP BY OrderId
    ];

    Map<Id, Decimal> countOfOrderItem = new Map<Id, Decimal>();

    for (AggregateResult ar : agr) {
        countOfOrderItem.put(
            (Id) ar.get('OrderId'),
            (Decimal) ar.get('totalQty')
        );
    }

    List<Order> updateOrder = new List<Order>();

    for (Order ord : [
        SELECT Id, Total_Items__c
        FROM Order
        WHERE Id IN :ordIds
    ]) {

        Decimal count =
            countOfOrderItem.containsKey(ord.Id)
            ? countOfOrderItem.get(ord.Id)
            : 0;

        updateOrder.add(
            new Order(
                Id = ord.Id,
                Total_Items__c = count
            )
        );
    }

    if (!updateOrder.isEmpty()) {
        update updateOrder;
    }
}
}