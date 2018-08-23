class UnofficialEvent < Event
    belongs_to :creator,class_name: 'Student' #chi lo crea
end