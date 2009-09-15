# What is Compaction?

Compaction aims to provide reusable solutions to common problems that developers face when writing Flex applications. 

# Smart Forms

![Automatically disable forms when not editing.](http://www.compactcode.com/wp-content/uploads/2009/09/notediting.png)
![Automatically disable buttons when no changes have been made.](http://www.compactcode.com/wp-content/uploads/2009/09/notchanged.png)
![Automatically disable buttons when validators have failed.](http://www.compactcode.com/wp-content/uploads/2009/09/notvalid.png)
![Provide progress indicators for long running operations.](http://www.compactcode.com/wp-content/uploads/2009/09/saving.png)

# Easy Validation

    public class CustomerValidator implements IValidator {
        public function validate(item:Object, builder:IValidationBuilder): void {
            var customer:Customer = Customer(item);
            builder.string(customer.name, "name").notEmpty();
            builder.date(customer.birth, "birth").beforeToday();
            builder.number(customer.postcode, "postcode").between(0, 9999);
        }
    }

# Simple Binding

    <binder:FormBinder source="{model}" target="{editForm}" />