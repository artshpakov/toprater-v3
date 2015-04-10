module MedalsHelper

  def hash salt=nil
    @hash ||= Digest::MD5.hexdigest("#{ salt }#{ Time.now }")[0..4]
  end

  def widget_path options
    "http://5.9.0.5/widget/#{ options.delete(:id) }?p=#{ options.to_json }"
  end

end
