# What is Compaction?

Compaction aims to provide reusable solutions to common problems that developers face when writing Flex applications. 

# Smart Forms

<table width="100%">
  <tr>
    <td width="50%">![Automatically disable forms when not editing.](http://www.compactcode.com/wp-content/uploads/2009/09/notediting.png)</td>
    <td width="50%">![Automatically disable buttons when no changes have been made.](http://www.compactcode.com/wp-content/uploads/2009/09/notchanged.png)</td>
  </tr>
  <tr>
    <td width="50%">![Automatically disable buttons when validators have failed.](http://www.compactcode.com/wp-content/uploads/2009/09/notvalid.png)</td>
    <td width="50%">![Provide progress indicators for long running operations.](http://www.compactcode.com/wp-content/uploads/2009/09/saving.png)</td>
  </tr>
</table>

# Powerful Validation

    public class CustomerValidator implements IValidator {
        public function validate(item:Object, builder:IValidationBuilder): void {
            var customer:Customer = Customer(item);
            builder.string(customer.name, "name").notEmpty();
            builder.date(customer.birth, "birth").beforeToday();
            builder.number(customer.postcode, "postcode").between(0, 9999);
        }
    }

# Simple Binding

    <model:EditModel id="model" />
    <mx:Form id="editForm" width="100%" defaultButton="{saveButton}">
        <mx:FormItem label="Name">
            <mx:TextInput id="nameInput" />
        </mx:FormItem>
        <mx:FormItem label="Email">
            <mx:TextInput id="emailInput" />
        </mx:FormItem>
        <mx:FormItem direction="horizontal">
            <mx:Button id="saveButton" label="Save"/>
            <mx:Button id="cancelButton" label="Cancel" />
        </mx:FormItem>
    </mx:Form>
    <binder:FormBinder source="{model}" target="{editForm}" />