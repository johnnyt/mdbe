require File.expand_path '../environment', __FILE__

class MdbeApp < ::Sinatra::Base
  helpers Sinatra::JSON

  configure do
    enable :raise_errors, :logging, :show_exceptions
  end

  get '/' do
    File.read(File.expand_path '../public/index.html', __FILE__)
    #json :message => "Hello world! (from #{RUBY_ENGINE})"
  end

  get '/ids' do
    json(
      :persistentRootId => Maglev::PERSISTENT_ROOT.object_id,
      :maglevSystemId => Maglev::System.object_id,
      :defaultWorkspaceId => RubyWorkspace.default_instance.object_id,
      :evalObjectId => Mdbe.eval_object.object_id)
  end

  # Write Amber packages to disk
  put '/:type/:package' do
    File.open("./public/amber/#{params[:type]}/#{params[:package]}", 'w+') do |file|
      file.write request.body.read
    end
    'success'
  end




  def store_object(obj)
    Mdbe.store_debug_object(obj)
  end

  get '/object/index/:id' do
    id = params[:id].to_i
    ranges = {}

    params.each_pair do |key, value|
      parts = key.split("_")

      if parts[0] == "range"
        ranges[parts[1].to_sym] = [params["range_#{parts[1]}_from"], params["range_#{parts[1]}_to"]]
     end
   end

    depth = (params[:depth] || 2).to_i

    json({:success => true, :result => ObjectSpace._id2ref(id).to_database_view(depth, ranges, params)})
  end

  get '/object/evaluate/:id' do
    obj_id = Integer(params[:id])
    obj = ObjectSpace._id2ref(obj_id)
    code = params[:code]
    language = params[:language]
    depth = params[:depth] ? Integer(params[:depth]) : 2
    ranges = {}

    if obj == nil and obj_id != 20
      render :json => {:success => false, :exception => "object not found"}
    else
      result = CodeEvaluation.wait_for_eval_thread do
        if language == "smalltalk"
          obj.__evaluate_smalltalk(code)
        elsif language == "ruby"
          obj.instance_eval(code)
        elsif language == "rubyClass"
          obj.module_eval(code)
        end
      end

      store_object(result)

      if result[0]
        # exception was caught
        json({:success => true, :result => [true, result[1].to_database_view(1, ranges, params)]})
      else
        # no exception was caught
        json({:success => true, :result => [false, result[1].to_database_view(depth, ranges, params)]})
      end
    end
  end

  get '/code/selectors/:id' do
    id = Integer(params[:id])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      render :json => {:success => true, :result => obj.__selectors_by_category}
    end
  end

  get '/code/code/:id' do
    id = Integer(params[:id])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      render :json => {:success => true, :result => obj.__source_for_selector(params[:selector], params[:language].to_sym)}
    end
  end

  get '/code/frame/:id' do
    id = Integer(params[:id])
    index = Integer(params[:index])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      render :json => {:success => true, :result => obj.__stack_frame(index)}
    end
  end

  get '/code/frames/:id' do
    id = Integer(params[:id])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      render :json => {:success => true, :result => obj.__stack_method_names}
    end
  end

  get '/code/stepInto/:id' do
    id = Integer(params[:id])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      p obj
      render :json => {:success => true, :result => obj.__step_into.to_database_view(1, {}, {})}
    end
  end

  get '/code/proceed/:id' do
    id = Integer(params[:id])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      result = obj.run
      sleep 0.1 until (obj.stop? and obj[:manual_stop]) or obj[:is_rails_thread]
      render :json => {:success => true, :result => result}
    end
  end

  get '/code/trim/:id' do
    id = Integer(params[:id])
    obj = ObjectSpace._id2ref(id)
    index = Integer(params[:index])

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      obj.__trim_stack_to_level(index)
      render :json => {:success => true, :result => true}
    end
  end

  get '/code/stepOver/:id' do
    id = Integer(params[:id])
    index = Integer(params[:index])
    obj = ObjectSpace._id2ref(id)

    if obj == nil and id != 20
      render :json => {:success => false, :exception => "object with id #{id} not found"}
    else
      render :json => {:success => true, :result => obj.__step_over_at(index).to_database_view(1, {}, {})}
    end
  end
end
