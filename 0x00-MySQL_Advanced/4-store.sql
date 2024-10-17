-- Create a trigger to decrease the quantity of an item
-- after adding a new order

DELIMITER $$

CREATE TRIGGER update_item_quantity
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    -- Update the quantity of the item after
    -- a new order is added
    UPDATE items
    SET quantity = quantity - NEW.order_quantity
    WHERE item_id = NEW.item_id;
END$$

DELIMITER ;
