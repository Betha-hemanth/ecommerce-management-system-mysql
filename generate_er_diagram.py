from PIL import Image, ImageDraw, ImageFont
import textwrap

# Create image
img_width, img_height = 1600, 1200
img = Image.new('RGB', (img_width, img_height), color='white')
draw = ImageDraw.Draw(img)

# Try to use a nice font, fall back to default if not available
try:
    title_font = ImageFont.truetype("arial.ttf", 20)
    table_font = ImageFont.truetype("arial.ttf", 11)
    label_font = ImageFont.truetype("arial.ttf", 9)
except:
    title_font = ImageFont.load_default()
    table_font = ImageFont.load_default()
    label_font = ImageFont.load_default()

# Draw title
draw.text((800, 20), 'E-Commerce Database - Entity Relationship Diagram', 
         fill='black', font=title_font, anchor='mm')

# Define table positions and data
tables = {
    'customers': {
        'pos': (150, 300),
        'columns': ['customer_id (PK)', 'customer_name', 'email', 'phone_number', 'city', 'registration_date'],
        'color': (255, 228, 225)
    },
    'addresses': {
        'pos': (150, 650),
        'columns': ['address_id (PK)', 'customer_id (FK)', 'address_type', 'street', 'city', 'state', 'pincode'],
        'color': (225, 245, 254)
    },
    'categories': {
        'pos': (550, 300),
        'columns': ['category_id (PK)', 'category_name'],
        'color': (241, 248, 233)
    },
    'products': {
        'pos': (550, 650),
        'columns': ['product_id (PK)', 'product_name', 'category_id (FK)', 'price', 'stock', 'seller_name'],
        'color': (255, 243, 224)
    },
    'orders': {
        'pos': (1000, 400),
        'columns': ['order_id (PK)', 'customer_id (FK)', 'order_date', 'shipping_address_id (FK)', 'order_status'],
        'color': (243, 229, 245)
    },
    'order_items': {
        'pos': (1000, 750),
        'columns': ['order_item_id (PK)', 'order_id (FK)', 'product_id (FK)', 'quantity', 'price_at_purchase'],
        'color': (252, 228, 236)
    },
    'payments': {
        'pos': (1400, 750),
        'columns': ['payment_id (PK)', 'order_id (FK)', 'payment_date', 'payment_method', 'amount', 'payment_status'],
        'color': (224, 242, 241)
    },
    'reviews': {
        'pos': (400, 1000),
        'columns': ['review_id (PK)', 'customer_id (FK)', 'product_id (FK)', 'rating', 'review_text', 'review_date'],
        'color': (255, 249, 196)
    }
}

# Box dimensions
box_width = 180
box_height_base = 30
line_height = 20

# Draw tables
table_boxes = {}
for table_name, table_data in tables.items():
    x, y = table_data['pos']
    columns = table_data['columns']
    color = table_data['color']
    
    # Calculate box height
    box_height = box_height_base + len(columns) * line_height
    
    # Draw box
    draw.rectangle([x - box_width//2, y - box_height//2, x + box_width//2, y + box_height//2],
                   outline='#333333', fill=color, width=2)
    
    # Store box coordinates for relationship lines
    table_boxes[table_name] = (x - box_width//2, y - box_height//2, x + box_width//2, y + box_height//2)
    
    # Add table name
    draw.text((x, y - box_height//2 + 15), table_name.upper(), 
             fill='black', font=table_font, anchor='mm')
    
    # Add separator line
    sep_y = y - box_height//2 + 30
    draw.line([(x - box_width//2 + 5, sep_y), (x + box_width//2 - 5, sep_y)], 
             fill='#999999', width=1)
    
    # Add columns
    y_offset = sep_y + 8
    for column in columns:
        # Wrap long column names
        wrapped = textwrap.fill(column, width=20)
        draw.text((x, y_offset), wrapped, 
                 fill='#333333', font=label_font, anchor='mm')
        y_offset += line_height

# Define relationships
relationships = [
    ('customers', 'addresses'),
    ('customers', 'orders'),
    ('customers', 'reviews'),
    ('categories', 'products'),
    ('products', 'order_items'),
    ('products', 'reviews'),
    ('orders', 'order_items'),
    ('orders', 'payments'),
    ('addresses', 'orders'),
]

# Draw relationship lines
for source, target in relationships:
    x1, y1, x2, y2 = table_boxes[source][2], table_boxes[source][3], \
                      table_boxes[target][0], table_boxes[target][1]
    
    # Draw line from right side of source to left side of target
    draw.line([(x1, (table_boxes[source][1] + table_boxes[source][3])//2), 
               (x2, (table_boxes[target][1] + table_boxes[target][3])//2)],
             fill='#666666', width=1)

# Add legend
legend_y = 70
draw.text((1350, legend_y), 'Legend:', fill='black', font=table_font)
draw.text((1350, legend_y + 25), 'PK = Primary Key', fill='#333333', font=label_font)
draw.text((1350, legend_y + 45), 'FK = Foreign Key', fill='#333333', font=label_font)

# Save image
img.save('ecommerce_er_diagram.png')
print("✅ ER Diagram generated successfully!")
print("📊 File created: ecommerce_er_diagram.png")
