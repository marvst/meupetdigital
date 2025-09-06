class TagsController < ApplicationController
  def show
    @pet = Pet.find_by_uuid(params[:uuid])
    
    if @pet.nil?
      render :not_found, status: :not_found
      return
    end
    
    @pet_infos = @pet.pet_infos.order(:name, :value)
    
    # Generate QR code
    qr = RQRCode::QRCode.new(tags_show_url(uuid: @pet.uuid))
    @qr_code = qr.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 4,
      standalone: true
    )
  end
  
  def qr
    @pet = Pet.find_by_uuid(params[:uuid])
    
    if @pet.nil?
      render :not_found, status: :not_found
      return
    end
    
    # Generate QR code for download as PNG
    qr = RQRCode::QRCode.new(tags_show_url(uuid: @pet.uuid))
    png = qr.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6
    )
    
    send_data png.to_s, 
              type: 'image/png', 
              disposition: 'attachment', 
              filename: "#{@pet.name.downcase.gsub(/\s+/, '_')}_qr_code.png"
  end
  
  def not_found
    # This will render the not_found.html.erb template
  end
end
