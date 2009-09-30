# What is compaction?

Compaction is an unobtrusive Flex library designed to make creating forms easier.

# How do I use it?

Take a standard mxml form.

    <mx:Form id="form" width="100%">
        <mx:FormItem label="Name">
            <mx:TextInput id="nameInput" />
        </mx:FormItem>
        <mx:FormItem direction="horizontal">
            <mx:Button id="saveButton" label="Save" />
            <mx:Button id="cancelButton" label="Cancel"/>
        </mx:FormItem>
    </mx:Form>

Drop in the compaction edit model.

    <model:EditModel id="model" />
    <mx:Form id="form" width="100%">
        <mx:FormItem label="Name">
            <mx:TextInput id="nameInput" />
        </mx:FormItem>
        <mx:FormItem direction="horizontal">
            <mx:Button id="saveButton" label="Save" />
            <mx:Button id="cancelButton" label="Cancel"/>
        </mx:FormItem>
    </mx:Form>

And bind your text input to the model.

    <model:EditModel id="model" />
    <mx:Form id="form" width="100%">
        <mx:FormItem label="Name">
            <mx:TextInput id="nameInput" />
        </mx:FormItem>
        <mx:FormItem direction="horizontal">
            <mx:Button id="saveButton" label="Save" />
            <mx:Button id="cancelButton" label="Cancel"/>
        </mx:FormItem>
    </mx:Form>
    <binder:TextBinder source="{model.edited}" property="name" target="{nameInput}" />

This will create a two way binding between your text input and the compaction edit model.

# How do I ...

### 1. Edit a new object?

    model.edit.execute(new Customer());

### 2. Work out if the user has made any changes?

    model.changed.currentValue;

### 3. Provide a way to undo any changes the user has made?

    <binder:ActionBinder source="{model.cancel}" target="{cancelButton}" />

### 4. Provide a way to save any changes the user has made?

    <binder:ActionBinder source="{model.save}" target="{saveButton}" />

### 5. Disable my form when nothing is being edited.

    <binder:ConditionBinder source="{model.editing}" target="{form}" />

### 6. Disable my save and cancel buttons until the user has made a change?

This is done automatically by the action binder shown in steps 3 and 4.

### 7. Validate any changes the user makes.

First create a validator.

    public class CustomerValidator implements IValidator {
        public function validate(item:Object, builder:IValidationBuilder): void {
            var customer:Customer = Customer(item);
            builder.string(customer.name, "name").notEmpty();
        }
    }

Then assign it to the edit model.

    <validator:CustomerValidator id="validator" />
    <model:EditModel id="model" validator="{validator}"/>

### 8. Disable my save button if any changes fail validation.

This is done automatically by the action binder shown in step 3.

### 9. Display validation failures on a UI component.

    <binder:ValidationBinder source="{model.adapter}" target="{nameInput}" />

### 10. Do everything mention above in under 15 lines of code?

    <validator:CustomerValidator id="validator" />
    <model:EditModel id="model" validator="{validator}"/>
    <mx:Form id="form" width="100%">
        <mx:FormItem label="Name">
            <mx:TextInput id="nameInput" />
        </mx:FormItem>
        <mx:FormItem direction="horizontal">
            <mx:Button id="saveButton" label="Save" />
            <mx:Button id="cancelButton" label="Cancel"/>
        </mx:FormItem>
    </mx:Form>
    <binder:FormBinder source="{model}" target="{form}" />
