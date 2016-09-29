/**
 * Option이 grouping된 Combobox생성..
 */
Ext.define('Ext.form.field.ux.ComboGrouping', {
    extend: 'Ext.form.field.ComboBox',
    alias: 'widget.combogrouping',

    width: 300,
    valueField : 'company',  // <-- 설정..
    // fieldLabel: 'Grid Picker',

    groupField: 'group',
	listConfig: {
		cls: 'combobox-grouped-list'
	},
	initComponent: function() {
		var me = this;
		me.tpl = new Ext.XTemplate([
			'{[this.currentGroup = null]}',
			'<tpl for=".">',
			'   <tpl if="this.shouldShowHeader('+me.groupField+')">',
			'       <div class="combobox-group-header">{[this.showHeader(values.'+me.groupField+')]}</div>',
			'   </tpl>',
			'   <div class="x-boundlist-item">{'+me.displayField+'}</div>',
			'</tpl>',
			{  
				shouldShowHeader: function(group){
					return this.currentGroup != group;
				},
				showHeader: function(group){
					this.currentGroup = group;
					return group;
				}
			}
		]);
		me.callParent(arguments);

		me.store =  Ext.create('Ext.data.ArrayStore', {
			fields: ['name', 'cuisine'],
	        sorters: ['cuisine','name'],
	        groupField: 'cuisine',
	        data: [{
			            name: 'Cheesecake Factory',
			            cuisine: 'American'
			        },{
			            name: 'University Cafe',
			            cuisine: 'American'
			        },{
			            name: 'Slider Bar',
			            cuisine: 'American'
			        },{
			            name: 'Shokolaat',
			            cuisine: 'American'
			        },{
			            name: 'Gordon Biersch',
			            cuisine: 'American'
			        },{
			            name: 'Crepevine',
			            cuisine: 'American'
			        },{
			            name: 'Creamery',
			            cuisine: 'American'
			        },{
			            name: 'Old Pro',
			            cuisine: 'American'
			        },{
			            name: 'Nola\'s',
			            cuisine: 'Cajun'
			        },{
			            name: 'House of Bagels',
			            cuisine: 'Bagels'
			        },{
			            name: 'The Prolific Oven',
			            cuisine: 'Sandwiches'
			        },{
			            name: 'La Strada',
			            cuisine: 'Italian'
			        },{
			            name: 'Buca di Beppo',
			            cuisine: 'Italian'
			        },{
			            name: 'Pasta?',
			            cuisine: 'Italian'
			        },{
			            name: 'Madame Tam',
			            cuisine: 'Asian'
			        },{
			            name: 'Sprout Cafe',
			            cuisine: 'Salad'
			        },{
			            name: 'Pluto\'s',
			            cuisine: 'Salad'
			        },{
			            name: 'Junoon',
			            cuisine: 'Indian'
			        },{
			            name: 'Bistro Maxine',
			            cuisine: 'French'
			        },{
			            name: 'Three Seasons',
			            cuisine: 'Vietnamese'
			        },{
			            name: 'Sancho\'s Taquira',
			            cuisine: 'Mexican'
			        },{
			            name: 'Reposado',
			            cuisine: 'Mexican'
			        },{
			            name: 'Siam Royal',
			            cuisine: 'Thai'
			        },{
			            name: 'Krung Siam',
			            cuisine: 'Thai'
			        },{
			            name: 'Thaiphoon',
			            cuisine: 'Thai'
			        },{
			            name: 'Tamarine',
			            cuisine: 'Vietnamese'
			        },{
			            name: 'Joya',
			            cuisine: 'Tapas'
			        },{
			            name: 'Jing Jing',
			            cuisine: 'Chinese'
			        },{
			            name: 'Patxi\'s Pizza',
			            cuisine: 'Pizza'
			        },{
			            name: 'Evvia Estiatorio',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'Cafe 220',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'Cafe Renaissance',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'Kan Zeman',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'Gyros-Gyros',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'Mango Caribbean Cafe',
			            cuisine: 'Caribbean'
			        },{
			            name: 'Coconuts Caribbean Restaurant & Bar',
			            cuisine: 'Caribbean'
			        },{
			            name: 'Rose & Crown',
			            cuisine: 'English'
			        },{
			            name: 'Baklava',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'Mandarin Gourmet',
			            cuisine: 'Chinese'
			        },{
			            name: 'Bangkok Cuisine',
			            cuisine: 'Thai'
			        },{
			            name: 'Darbar Indian Cuisine',
			            cuisine: 'Indian'
			        },{
			            name: 'Mantra',
			            cuisine: 'Indian'
			        },{
			            name: 'Janta',
			            cuisine: 'Indian'
			        },{
			            name: 'Hyderabad House',
			            cuisine: 'Indian'
			        },{
			            name: 'Starbucks',
			            cuisine: 'Coffee'
			        },{
			            name: 'Peet\'s Coffee',
			            cuisine: 'Coffee'
			        },{
			            name: 'Coupa Cafe',
			            cuisine: 'Coffee'
			        },{
			            name: 'Lytton Coffee Company',
			            cuisine: 'Coffee'
			        },{
			            name: 'Il Fornaio',
			            cuisine: 'Italian'
			        },{
			            name: 'Lavanda',
			            cuisine: 'Mediterranean'
			        },{
			            name: 'MacArthur Park',
			            cuisine: 'American'
			        },{
			            name: 'St Michael\'s Alley',
			            cuisine: 'Californian'
			        },{
			            name: 'Cafe Renzo',
			            cuisine: 'Italian'
			        },{
			            name: 'Osteria',
			            cuisine: 'Italian'
			        },{
			            name: 'Vero',
			            cuisine: 'Italian'
			        },{
			            name: 'Cafe Renzo',
			            cuisine: 'Italian'
			        },{
			            name: 'Miyake',
			            cuisine: 'Sushi'
			        },{
			            name: 'Sushi Tomo',
			            cuisine: 'Sushi'
			        },{
			            name: 'Kanpai',
			            cuisine: 'Sushi'
			        },{
			            name: 'Pizza My Heart',
			            cuisine: 'Pizza'
			        },{
			            name: 'New York Pizza',
			            cuisine: 'Pizza'
			        },{
			            name: 'California Pizza Kitchen',
			            cuisine: 'Pizza'
			        },{
			            name: 'Round Table',
			            cuisine: 'Pizza'
			        },{
			            name: 'Loving Hut',
			            cuisine: 'Vegan'
			        },{
			            name: 'Garden Fresh',
			            cuisine: 'Vegan'
			        },{
			            name: 'Cafe Epi',
			            cuisine: 'French'
			        },{
			            name: 'Tai Pan',
			            cuisine: 'Chinese'
			        }]
                  })
	}

});