class EditTimerScreen < PM::FormotionScreen
  title ""

  attr_accessor :timer

  def on_create(args={})
    super(args)

    set_nav_bar_button :right, title: "Delete", action: :delete_timer
  end

  def delete_timer
    open DeleteTimerScreen.new(:timer => timer)
  end

  def on_submit(_form)
    formValues = _form.render
    name = formValues[:name]

    if name && name != ""
      timer.name = name
      cdq.save

      close_screen
    else
      App.alert "Please enter a name", {
        :cancel_button_title => "Ok"
      }
    end
  end

  def table_data
    {
      :sections => [{
        :title => nil,
        :key   => :primary_values,
        :rows  => [{
          :key   => :name,
          :type  => :string,
          :value => timer.name
        }, {
          :title => "Save",
          :type  => :submit
        }]
      }]
    }
  end
end
