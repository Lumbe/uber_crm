module ControllerMacros

  # include associations into attributes - https://github.com/thoughtbot/factory_girl/issues/359#issuecomment-135890010
  def attributes_with_foreign_keys(*args)
    inst = FactoryGirl.build(*args)
    attrs = inst.attributes
    attrs.delete_if do |k, v| 
      ['id', 'type', 'created_at', 'updated_at'].member?(k)
    end
    inst.class.defined_enums.each { |k, v| attrs[k] = inst.send(k) }
    attrs
  end

end